class_name LeverBefore
extends Node2D


func _ready():
	enable()

func setState(state):
	match state:
		0:
			enable()
		1:
			disable()

#DEPRECATED
func _on_lever_activate():
	disable()

#DEPRECATED
func _on_lever_deactivate():
	enable()

func enable():
	visible = true
	for child in get_children():
		if child.has_method("enable"):
			child.enable()

func disable():
	visible = false
	for child in get_children():
		if child.has_method("disable"):
			child.disable()
