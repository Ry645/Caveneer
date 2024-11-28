@tool
class_name Lever
extends AnimatedSprite2D

## DEPRECATED
signal activated
## DEPRECATED
signal deactivated

## can connect to another lever interact() method to activate it
## useful for levers with different lever manager parents
signal setState(state:int)

## for room 5's nice try bud
signal triedToInteractButFailed

@export var outlineShader:Shader = preload("res://outline/outline.gdshader")
@export var isOneShot = true
@export var canInteract = true
## for audio
@export var isImportant:bool = false

var isActive = false

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		if isOneShot:
			animation = "oneShot"
		else:
			animation = "toggle"

func _ready() -> void:
	var shaderMaterial:ShaderMaterial = ShaderMaterial.new()
	shaderMaterial.shader = outlineShader
	material = shaderMaterial
	
	if isOneShot:
		animation = "oneShot"
	else:
		animation = "toggle"

func setImportant():
	isImportant = true

func interact():
	if !canInteract:
		emit_signal("triedToInteractButFailed")
		return
	
	if isActive && isOneShot:
		return 1
	
	playSound()
	
	isActive = !isActive
	frame = 1 if isActive else 0
	
	if isActive:
		activate()
	else:
		deactivate()
	
	return 0

func activate():
	if get_parent().has_method("activatedLever"):
		get_parent().activatedLever()
	#do not connect to parent, connect to a separate lever manager
	emit_signal("activated")
	emit_signal("setState", 1)

func deactivate():
	if get_parent().has_method("deactivatedLever"):
		get_parent().deactivatedLever()
	#do not connect to parent, connect to a separate lever manager
	emit_signal("deactivated")
	emit_signal("setState", 0)

func enable():
	visible = true
	($Area2D as Area2D).set_collision_layer_value(2, true)

func disable():
	visible = false
	($Area2D as Area2D).set_collision_layer_value(2, false)


func sync(state):
	if isOneShot:
		return
	
	match state:
		0:
			isActive = false
		1:
			isActive = true
	
	frame = 1 if isActive else 0
	
	# doesn't call to the parent so only one lever controls the lever manager
	# other than it's own setState signal since that's for separate objects
	if isActive:
		emit_signal("setState", 1)
	else:
		emit_signal("setState", 0)
	


func hover():
	if !canInteract:
		return
	
	if isActive && isOneShot:
		return 
	
	showOutline()
	await get_tree().physics_frame
	hideOutline()

func showOutline():
	material.set_shader_parameter("process", true)

func hideOutline():
	material.set_shader_parameter("process", false)


func toggleInteractability():
	setInteractability(!$Area2D.monitorable)

func setInteractability(value:bool):
	canInteract = value

func playSound():
	if isImportant:
		$importantToggleSound.volume_db = 0
		$importantToggleSound.play()
		# wait for LOUD PING
		await get_tree().create_timer(0.85).timeout
		$importantToggleSound.volume_db = 10
	else:
		$toggleSound.play()


func _on_set_state(state: int) -> void:
	toggleInteractability()
