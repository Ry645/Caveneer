extends Sprite2D


func interact():
	if get_parent().has_method("pulledLever"):
		get_parent().pulledLever()
	else:
		breakpoint
