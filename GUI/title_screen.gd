extends Control


@export var pbScene:PackedScene = preload("res://GUI/personalBestsScene/personal_bests_scene.tscn")
@export var options:PackedScene = preload("res://GUI/options.tscn")


func _ready() -> void:
	showMouse()
	if !GameGlobal.gameStarted:
		GameGlobal.loadGameIntro()
		return
	
	if !GameGlobal.gameCompleted:
		$vbox/control.queue_free()
		$vbox/pbButton.queue_free()
		$vbox/control2.queue_free()
		$vbox/optionsButton.queue_free()
	
	await get_tree().process_frame
	showMouse()

func showMouse():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func playButton() -> void:
	GameGlobal.loadFirstLevel()

func pbButton():
	GameGlobal.loadUI(pbScene)

func optionsButton():
	GameGlobal.loadUI(options)

func _on_button_up_save_and_exit_game_button() -> void:
	GameGlobal.exitGame()
