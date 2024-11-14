extends Node2D


func _ready():
	visible = true



func _on_lever_activate():
	visible = false
	for child in get_children():
		# WARNING might not work but we'll see
		process_mode = Node.PROCESS_MODE_DISABLED
