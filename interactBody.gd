extends Node2D


func interact():
	if get_parent().has_method("interact"):
		get_parent().interact()
	else:
		print("idiot forgot to define the interact method smh")
		breakpoint
