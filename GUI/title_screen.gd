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
	GameGlobal.loadUI(levelSelect)

func optionsButton():
	GameGlobal.loadUI(options)

func _on_button_up_save_and_exit_game_button() -> void:
	GameGlobal.save_game()
	get_tree().quit()
