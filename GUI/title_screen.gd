extends Control


@export var firstLevel:PackedScene = preload("res://zones/firstCave/first_cave_room1.tscn")
@export var levelSelect:PackedScene = preload("res://GUI/level_select.tscn")
@export var options:PackedScene = preload("res://GUI/options.tscn")


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if !GameGlobal.gameCompleted:
		$vbox/control.queue_free()
		$vbox/levelSelectButton.queue_free()
		$vbox/control2.queue_free()
		$vbox/optionsButton.queue_free()


func playButton() -> void:
	GameGlobal.loadArea(firstLevel)

func levelSelectButton():
	GameGlobal.loadArea(levelSelect)

func optionsButton():
	GameGlobal.loadArea(options)
