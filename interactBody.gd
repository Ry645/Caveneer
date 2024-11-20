extends Node2D


func interact():
	if get_parent().has_method("interact"):
		return get_parent().interact()
	else:
		print("idiot forgot to define the interact method in ", get_parent(), " smh")
		breakpoint
		return 1

func hover():
	get_parent().hover()
