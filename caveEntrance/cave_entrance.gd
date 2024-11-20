class_name CaveEntrance
extends Sprite2D

@export var sceneToLoad:PackedScene # = preload("res://zones/firstCave/first_cave.tscn")


func loadArea():
	get_node("/root").get_tree().change_scene_to_packed(sceneToLoad)


func interact():
	loadArea()

func interactHover():
	pass

func hover():
	showOutline()
	await get_tree().physics_frame
	hideOutline()

func showOutline():
	material.set_shader_parameter("process", true)

func hideOutline():
	material.set_shader_parameter("process", false)
