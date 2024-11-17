class_name Lever
extends AnimatedSprite2D

## can connect to another lever interact() method to activate it
## useful for levers with different lever manager parents
signal activated

signal deactivated

@export var outlineShader:Shader = preload("res://outline/outline.gdshader")
@export var isOneShot = true

var isActive = false

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
	
	isActive = !isActive
	frame = 1 if isActive else 0
	
	if isActive:
		if get_parent().has_method("activatedLever"):
			get_parent().activatedLever()
		#do not connect to parent, connect to a separate lever manager
		emit_signal("activated")
	else:
		if get_parent().has_method("deactivatedLever"):
			get_parent().deactivatedLever()
		#do not connect to parent, connect to a separate lever manager
		emit_signal("deactivated")
	

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
