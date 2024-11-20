class_name ToggleArea
extends Node2D

## naming convention: toggleAreaActive1 or toggleAreaInactive1

@export var isActive:bool = false

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
