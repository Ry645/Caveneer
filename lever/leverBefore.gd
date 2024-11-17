class_name LeverBefore
extends Node2D


func _ready():
	visible = true



func _on_lever_activate():
	visible = false
	for child in get_children():
		if child.has_method("disable"):
			child.disable()

func _on_lever_deactivate():
	visible = true
	for child in get_children():
		if child.has_method("enable"):
			child.enable()
