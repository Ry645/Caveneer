extends Area2D


func interact():
	if get_parent().has_method("interact"):
		return get_parent().interact()

func hover():
	get_parent().hover()
