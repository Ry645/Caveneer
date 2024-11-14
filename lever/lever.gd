extends Sprite2D


func interact():
	# lever already pulled
	($Area2D as Area2D).set_collision_layer_value(2, false)
	
	if get_parent().has_method("pulledLever"):
		get_parent().pulledLever()
	else:
		breakpoint

func enable():
	visible = true
	($Area2D as Area2D).set_collision_layer_value(2, true)

func disable():
	visible = false
	($Area2D as Area2D).set_collision_layer_value(2, false)
