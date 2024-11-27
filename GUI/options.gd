extends Control




func _on_toggled_speedrun_timer(toggled_on: bool) -> void:
	GameGlobal.speedrunTimerEnabled = toggled_on


func _on_toggled_magic_shield(toggled_on: bool) -> void:
	GameGlobal.magicShieldEnabled = toggled_on


func _on_toggled_rank(toggled_on: bool) -> void:
	GameGlobal.rankEnabled = toggled_on
