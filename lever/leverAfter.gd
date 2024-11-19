class_name LeverAfter
extends Node2D


func _ready():
	disable()

func setState(state):
	match state:
		0:
			disable()
		1:
			enable()

#DEPRECATED
func _on_lever_activate():
	enable()

#DEPRECATED
func _on_lever_deactivate():
	disable()


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
