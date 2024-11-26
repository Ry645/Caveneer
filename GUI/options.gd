extends Control




func _on_toggled_speedrun_timer(toggled_on: bool) -> void:
	GameGlobal.speedrunTimer = toggled_on


func _on_toggled_magic_shield(toggled_on: bool) -> void:
	GameGlobal.magicShield = toggled_on


func _on_toggled_rank(toggled_on: bool) -> void:
	GameGlobal.rank = toggled_on
