extends Node2D


func _ready():
	visible = false
	for child in get_children():
		process_mode = Node.PROCESS_MODE_DISABLED


func _on_lever_activate():
	visible = true
	for child in get_children():
		process_mode = Node.PROCESS_MODE_INHERIT
