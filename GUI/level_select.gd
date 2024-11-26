extends Control

@export var levels:Array[PackedScene] = [
	preload("res://zones/firstCave/first_cave_room1.tscn"),
	preload("res://zones/firstCave/first_cave_room2.tscn"),
	preload("res://zones/firstCave/first_cave_room3.tscn"),
	preload("res://zones/firstCave/first_cave_room4.tscn"),
	preload("res://zones/firstCave/first_cave_room5.tscn"),
	preload("res://zones/firstCave/first_cave_room6.tscn"),
]

func _on_button_up_level_1() -> void:
	GameGlobal.loadArea(levels[0])


func _on_button_up_level_2() -> void:
	GameGlobal.loadArea(levels[1])


func _on_button_up_level_3() -> void:
	GameGlobal.loadArea(levels[2])


func _on_button_up_level_4() -> void:
	GameGlobal.loadArea(levels[3])


func _on_button_up_level_5() -> void:
	GameGlobal.loadArea(levels[4])


func _on_button_up_level_6() -> void:
	GameGlobal.loadArea(levels[5])
