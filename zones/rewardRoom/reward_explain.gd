extends Control

@export var firstLevel:PackedScene = preload("res://zones/firstCave/first_cave_room1.tscn")

var screens:Array[Node]
var index:int = 0

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	screens = get_tree().get_nodes_in_group("screen")
	
	for screen in screens:
		screen.visible = false
	screens[0].visible = true

func advance():
	screens[index].queue_free()
	if index < screens.size() - 1:
		screens[index + 1].visible = true
	else:
		loadStart()
	index += 1


func loadStart():
	get_node("/root").get_tree().change_scene_to_packed(firstLevel)

func _on_button_up_button() -> void:
	advance()
