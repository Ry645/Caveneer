extends Control


func _ready() -> void:
	$vbox/speedrunTimer.button_pressed = GameGlobal.speedrunTimerEnabled
	$vbox/magicShield.button_pressed = GameGlobal.magicShieldEnabled
	$vbox/rank.button_pressed = GameGlobal.rankEnabled


func _on_toggled_speedrun_timer(toggled_on: bool) -> void:
	GameGlobal.speedrunTimerEnabled = toggled_on


func _on_toggled_magic_shield(toggled_on: bool) -> void:
	GameGlobal.magicShieldEnabled = toggled_on


func _on_toggled_rank(toggled_on: bool) -> void:
	GameGlobal.rankEnabled = toggled_on


func _on_button_up_back_button() -> void:
	GameGlobal.loadTitleScreen()
