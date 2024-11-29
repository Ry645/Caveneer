extends Button

func _ready() -> void:
	if !OS.has_feature("web"):
		queue_free()
		return
	
	visible = true
	for child in get_children():
		child.visible = false

func _on_button_up() -> void:
	for child in get_children():
		child.visible = true


func _on_button_up_collapse_button() -> void:
	for child in get_children():
		child.visible = false
