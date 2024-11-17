class_name LeverBefore
extends Node2D


func _ready():
	enable()



func _on_lever_activate():
	disable()

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
