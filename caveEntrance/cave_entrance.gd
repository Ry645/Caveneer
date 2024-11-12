extends Sprite2D

@export var sceneToLoad:PackedScene # = preload("res://zones/firstCave/first_cave.tscn")


func loadArea():
	get_node("/root").get_tree().change_scene_to_packed(sceneToLoad)


func interact():
	loadArea()

func interactHover():
	pass
