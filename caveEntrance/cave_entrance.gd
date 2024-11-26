class_name CaveEntrance
extends Sprite2D

@export var sceneToLoad:PackedScene # = preload("res://zones/firstCave/first_cave.tscn")


func loadArea():
	GameGlobal.loadArea(sceneToLoad)


func interact():
	loadArea()
	return 0

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

func enable():
	visible = true
	($interactBody as StaticBody2D).set_collision_layer_value(1, true)
	($interactBody as StaticBody2D).set_collision_layer_value(2, true)

func disable():
	visible = false
	($interactBody as StaticBody2D).set_collision_layer_value(1, false)
	($interactBody as StaticBody2D).set_collision_layer_value(2, false)
