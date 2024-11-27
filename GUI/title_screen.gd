extends Control


@export var firstLevel:PackedScene = preload("res://zones/firstCave/first_cave_room1.tscn")
@export var pbScene:PackedScene = preload("res://GUI/personalBestsScene/personal_bests_scene.tscn")
@export var options:PackedScene = preload("res://GUI/options.tscn")


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if !GameGlobal.gameCompleted:
		$vbox/control.queue_free()
		$vbox/pbButton.queue_free()
		$vbox/control2.queue_free()
		$vbox/optionsButton.queue_free()


func playButton() -> void:
	GameGlobal.gameTimeRunning = true
	GameGlobal.restartTime()
	GameGlobal.loadArea(firstLevel)

func pbButton():
	GameGlobal.loadUI(pbScene)

func optionsButton():
	GameGlobal.loadUI(options)

func _on_button_up_save_and_exit_game_button() -> void:
	GameGlobal.save_game()
	get_tree().quit()
