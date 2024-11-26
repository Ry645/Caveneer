extends Control


@export var firstLevel:PackedScene = preload("res://zones/firstCave/first_cave_room1.tscn")
@export var levelSelect:PackedScene = preload("res://GUI/level_select.tscn")
@export var options:PackedScene = preload("res://GUI/options.tscn")


func _ready() -> void:
	if !GameGlobal.speedrunUnlocked:
		$vbox/control.queue_free()
		$vbox/levelSelectButton.queue_free()
		$vbox/control2.queue_free()
		$vbox/optionsButton.queue_free()


func playButton() -> void:
	get_node("/root").get_tree().change_scene_to_packed(firstLevel)

func levelSelectButton():
	get_node("/root").get_tree().change_scene_to_packed(levelSelect)

func optionsButton():
	get_node("/root").get_tree().change_scene_to_packed(options)
