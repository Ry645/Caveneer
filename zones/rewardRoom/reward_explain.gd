extends Control

@export var rankGetScene:PackedScene = preload("res://GUI/rank_get_scene.tscn")

var screens:Array[Node]
var index:int = 0

func _ready() -> void:
	if GameGlobal.gameCompleted:
		call_deferred("loadRankGetScene")
	else:
		GameGlobal.unlockEverything()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		screens = get_tree().get_nodes_in_group("screen")
		
		for screen in screens:
			screen.visible = false
		screens[0].visible = true
		
		$screen2/speedrunTimer.visible = true
		
		if $screen3/rankText.text == "S":
			$screen3/richTextLabel4.text = "[center]This isn't your first time."
		
		if $screen3/rankText.text == "F":
			$screen3/richTextLabel4.text = "[center]Why"

func loadRankGetScene():
	GameGlobal.loadUI(rankGetScene)

func advance():
	screens[index].queue_free()
	if index < screens.size() - 1:
		screens[index + 1].visible = true
	else:
		loadStart()
	index += 1


func loadStart():
	GameGlobal.loadFirstLevel()

func _on_button_up_button() -> void:
	advance()
