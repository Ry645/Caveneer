class_name ToggleArea
extends Node2D

## naming convention: toggleArea1 is active
## toggleArea1_2 is inactive 

@export var isActive:bool = false
@export var connectWith:Array[int]

func _ready():
	if isActive:
		enable()
	else:
		disable()

func toggle(_state):
	if isActive:
		disable()
	else:
		enable()

func enable():
	isActive = true
	visible = true
	for child in get_children():
		if child.has_method("enable"):
			child.enable()

func disable():
	isActive = false
	visible = false
	for child in get_children():
		if child.has_method("disable"):
			child.disable()
