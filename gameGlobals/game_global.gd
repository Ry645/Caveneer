extends Node

## saved on exit
@export var gameStarted:bool = false
@export var gameCompleted:bool = false
@export var speedrunTimerEnabled:bool = false
@export var magicShieldEnabled:bool = false
@export var rankEnabled:bool = false

#Array[int]
@export var ms_times:Dictionary = {
	"fullGame": [],
	"level1": [],
	"level2": [],
	"level3": [],
	"level4": [],
	"level5": [],
	"level6": [],
}

@export var currentLevel:int = 1
##

@export var timer:PackedScene = preload("res://speedrunTimer/speedrun_timer.tscn")
@export var titleScreen:PackedScene = preload("res://GUI/title_screen.tscn")
@export var debugMode:bool = false

var timeInGame:float = 0.0
var timeInLevel:float = 0.0
var gameTimeRunning:bool = false
var levelTimeRunning:bool = false

var timerNode:Node


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
	if gameTimeRunning:
		timeInGame += delta
	if levelTimeRunning:
		timeInLevel += delta
	

## loads area and adds a speedrun timer
func loadArea(sceneToLoad:PackedScene):
	get_node("/root").get_tree().change_scene_to_packed(sceneToLoad)
	addSpeedrunTimer()

func loadUI(sceneToLoad:PackedScene):
	get_node("/root").get_tree().change_scene_to_packed(sceneToLoad)
	if timerNode != null:
		timerNode.queue_free()
		timerNode = null

func loadTitleScreen():
	loadUI(titleScreen)

func addSpeedrunTimer():
	if timerNode != null:
		return
	
	var canvas = CanvasLayer.new()
	timerNode = timer.instantiate()
	canvas.add_child(timerNode)
	get_node("/root").add_child(canvas)

func restartTime():
	timeInGame = 0.0;



func save():
	var saveDict:Dictionary = {
		"gameStarted": gameStarted,
		"gameCompleted": gameCompleted,
		"speedrunTimerEnabled": speedrunTimerEnabled,
		"magicShieldEnabled": magicShieldEnabled,
		"rankEnabled": rankEnabled,
		"ms_times": ms_times,
		"currentLevel": currentLevel,
	}
	
	return saveDict


func save_game():
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


# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_game():
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
		for i in node_data.keys():
			set(i, node_data[i])
