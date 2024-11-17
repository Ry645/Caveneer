class_name Lever
extends AnimatedSprite2D

## can connect to another lever interact() method to activate it
## useful for levers with different lever manager parents
signal activated

@export var outlineShader:Shader = preload("res://outline/outline.gdshader")

@export var isActive = false
@export var isOneShot = true

func _ready() -> void:
	var shaderMaterial:ShaderMaterial = ShaderMaterial.new()
	shaderMaterial.shader = outlineShader
	material = shaderMaterial
	
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

func hover():
	if isActive && isOneShot:
		return 
	
	showOutline()
	await get_tree().physics_frame
	hideOutline()

func showOutline():
	material.set_shader_parameter("process", true)

func hideOutline():
	material.set_shader_parameter("process", false)
