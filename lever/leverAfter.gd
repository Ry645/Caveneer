class_name LeverAfter
extends Node2D


func _ready():
	_on_lever_deactivate()


func _on_lever_activate():
	visible = true
	for child in get_children():
		if child.has_method("enable"):
			child.enable()

func _on_lever_deactivate():
	visible = false
	for child in get_children():
		if child.has_method("disable"):
			child.disable()
