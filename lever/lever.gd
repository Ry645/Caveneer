class_name Lever
extends AnimatedSprite2D

## can connect to another lever interact() method to activate it
## useful for levers with different lever manager parents
signal activated

@export var isActive = false
@export var isOneShot = true

func _ready() -> void:
	if isOneShot:
		animation = "oneShot"
	else:
		animation = "toggle"

func interact():
	if isActive && isOneShot:
		return
	
	frame = 0 if isActive else 1
	isActive = !isActive
	
	if get_parent().has_method("pulledLever"):
		get_parent().pulledLever()
	else:
		#breakpoint
		print(self, ": no lever manager parent")

func enable():
	visible = true
	($Area2D as Area2D).set_collision_layer_value(2, true)

func disable():
	visible = false
	($Area2D as Area2D).set_collision_layer_value(2, false)
