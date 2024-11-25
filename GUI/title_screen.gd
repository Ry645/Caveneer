extends Control


@export var firstLevel:PackedScene = preload("res://zones/firstCave/first_cave_room1.tscn")
@export var levelSelect:PackedScene = preload("res://GUI/level_select.tscn")
@export var options:PackedScene = preload("res://GUI/options.tscn")



func playButton() -> void:
	get_node("/root").get_tree().change_scene_to_packed(firstLevel)

func levelSelectButton():
	get_node("/root").get_tree().change_scene_to_packed(levelSelect)

func optionsButton():
	get_node("/root").get_tree().change_scene_to_packed(options)
