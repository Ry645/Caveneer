extends Node

# INFO todo list
# BUG when game loaded from scene, can't pause, since game global doesn't load it in automatically

## saved on exit
@export var gameStarted:bool = false
@export var gameCompleted:bool = false
@export var speedrunTimerEnabled:bool = false
@export var magicShieldEnabled:bool = false
@export var rankEnabled:bool = false

@export var ms_times:Array[int]

@export var currentLevel:int = 1
##

@export var timer:PackedScene = preload("res://speedrunTimer/speedrun_timer.tscn")
@export var pauseMenuScene:PackedScene = preload("res://GUI/pauseMenu/pause_menu.tscn")


@export var titleScreen:PackedScene = preload("res://GUI/title_screen.tscn")
@export var gameIntro:PackedScene = preload("res://GUI/gameIntro/game_intro.tscn")
@export var firstLevel:PackedScene = preload("res://zones/firstCave/first_cave_room1.tscn")
@export var debugMode:bool = false
@export var dontSaveGame = false
@export var dontLoadGame = false

var timeInGame:float = 0.0
var timeInLevel:float = 0.0
var gameTimeRunning:bool = false
var levelTimeRunning:bool = false

var timerNode:Node
var pauseMenu:Control
var canvasLayer


func _ready() -> void:
	load_game()

func unlockEverything():
	if gameCompleted:
		return
	
	gameCompleted = true
	speedrunTimerEnabled = true
	magicShieldEnabled = true
	rankEnabled = true

func _process(delta: float) -> void:
	if get_tree().paused == true:
		return
	
	if gameTimeRunning:
		timeInGame += delta
	if levelTimeRunning:
		timeInLevel += delta
	

## loads area and adds a speedrun timer
func loadArea(sceneToLoad:PackedScene):
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_node("/root").get_tree().change_scene_to_packed(sceneToLoad)
	addSpeedrunTimer()
	addPauseMenu()

func loadUI(sceneToLoad:PackedScene):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_node("/root").get_tree().change_scene_to_packed(sceneToLoad)
	removeNodes()

func loadTitleScreen():
	loadUI(titleScreen)

func loadGameIntro():
	loadUI(gameIntro)

func loadFirstLevel():
	gameTimeRunning = true
	restartTime()
	loadArea(firstLevel)

func pauseGame():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pauseMenu.visible = true
	get_tree().paused = true

func unpauseGame():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pauseMenu.visible = false
	get_tree().paused = false

func addSpeedrunTimer():
	if timerNode != null:
		return
	
	if canvasLayer == null:
		canvasLayer = CanvasLayer.new()
		get_node("/root").add_child(canvasLayer)
	
	timerNode = timer.instantiate()
	canvasLayer.add_child(timerNode)

func addPauseMenu():
	if pauseMenu != null:
		return
	
	if canvasLayer == null:
		canvasLayer = CanvasLayer.new()
		get_node("/root").add_child(canvasLayer)
	
	pauseMenu = pauseMenuScene.instantiate()
	canvasLayer.add_child(pauseMenu)
	pauseMenu.visible = false

func removeNodes():
	if timerNode != null:
		timerNode.queue_free()
		timerNode = null
	if pauseMenu != null:
		pauseMenu.queue_free()
		pauseMenu = null

func restartTime():
	timeInGame = 0.0;

func addCurrentTimeToPBs():
	ms_times.append(RankData.secToMilliTime(timeInGame))
	ms_times.sort_custom(sort_ascending)

func exitGame():
	save_game()
	get_tree().quit()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		exitGame()


func save():
	var saveDict:Dictionary = {
		"gameStarted": gameStarted,
		"gameCompleted": gameCompleted,
		"speedrunTimerEnabled": speedrunTimerEnabled,
		"magicShieldEnabled": magicShieldEnabled,
		"rankEnabled": rankEnabled,
		"currentLevel": currentLevel,
	}
	
	return saveDict


func save_game():
	if dontSaveGame:
		return
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_file.store_line(json_string)
		
		saveMsTimes(node, save_file)


# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_game():
	if dontLoadGame:
		return
	
	if not FileAccess.file_exists("user://savegame.save"):
		print("save file doesn't exist")
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data
		
		
		# Now we set the remaining variables.
		if node_data is Dictionary:
			for i in node_data.keys():
				set(i, node_data[i])
		elif node_data is Array:
			ms_times.clear()
			for datum in node_data:
				ms_times.append(int(datum))

func saveMsTimes(node, save_file:FileAccess):
	# Call the node's save function.
	var node_data = GameGlobal.ms_times

	# JSON provides a static method to serialized JSON string.
	var json_string = JSON.stringify(node_data)

	# Store the save dictionary as a new line in the save file.
	save_file.store_line(json_string)






func sort_ascending(a, b):
	if a < b:
		return true
	return false
