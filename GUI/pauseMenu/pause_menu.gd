extends Control


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if visible:
			unpause()
		else:
			pause()

func _on_button_up_play_button() -> void:
	unpause()

func _on_button_up_title_button() -> void:
	unpause()
	GameGlobal.loadTitleScreen()



func unpause():
	hide()
	GameGlobal.unpauseGame()

func pause():
	show()
	GameGlobal.pauseGame()
