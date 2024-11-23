extends CharacterBody2D

#TODO add a bunch of new controls to the player
#TODO add a wall kick (if the player collides with anything above 128 speed, they have 0.5 seconds to wall kick) (stores previous speed after head-on collision and waits 0.5 seconds before player dash, sets that after dash) 
#TODO add a set cardinal direction for aim (locks player's grapple on an axis, not changing it until they let go) (ctrl)

@export var maxReach = 32
@export var brakePower = 5
@export var fullStopThreshold = 5

@export var hasDebugMovement:bool = false
@export var debugDashSpeed:int = 100

@onready var tools = [%grappleLash]
@onready var player_sprite = %playerSprite
@onready var carrying_transform = %carryingTransform


@onready var equippedTool = %grappleLash
@onready var holster = %grappleLashTransform

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	%grappleLash.user = self
	
	if hasDebugMovement:
		%grappleLash.hasDebugMovement = true
		set_collision_mask_value(1, false)
	
	pass

func _physics_process(delta):
	if hasDebugMovement:
		%grappleLash.hasDebugMovement = true
		set_collision_mask_value(1, false)
	else:
		%grappleLash.hasDebugMovement = false
		set_collision_mask_value(1, true)
	
	inputProcess(delta)
	updateAnimation()
	
	hover()
	
	move_and_slide()

func inputProcess(delta):
	if Input.is_action_just_pressed("interact"):
		#TODO maybe implement a buffer for this one idk
		for body in %interactArea.get_overlapping_bodies():
			if body.has_method("interact"):
				body.interact()
				#only interact with one thing
				break
		for area in %interactArea.get_overlapping_areas():
			if area.has_method("interact"):
				var exitCode = area.interact()
				# if interacted normally
				if exitCode == 0:
					#only interact with one thing
					break
	if Input.is_action_just_pressed("dash"):
		dash()
	# debug only
	if Input.is_action_pressed("dash"):
		if hasDebugMovement:
			debugSteer()
	if Input.is_action_pressed("brake"):
		slowPlayerMovement(delta)
	if Input.is_action_just_pressed("attack"):
		if equippedTool.has_method("use"):
			equippedTool.use()
	if Input.is_action_just_released("attack"):
		if equippedTool.has_method("stopUse"):
			equippedTool.stopUse()
	#TEMP later add pause menu
	if Input.is_action_just_pressed("pause"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.is_action_just_pressed("slot 1"):
		swapWeapon(1)
	#     not yet
	#if Input.is_action_just_pressed("slot 2"):
		#swapWeapon(2)
	#if Input.is_action_just_pressed("slot 3"):
		#swapWeapon(3) 

func hover():
	for body:Node2D in %interactArea.get_overlapping_bodies():
		if body.has_method("hover"):
			body.hover()
			#only hover over one thing
			break
	for area:Node2D in %interactArea.get_overlapping_areas():
		if area.has_method("hover"):
			area.hover()
			#only hover over one thing
			break

## equips new weapon and holsters old new
func swapWeapon(slot):
	#back to holster
	equippedTool.reparent(holster, false)
	#grab tool
	equippedTool = tools[slot - 1]
	#store holster
	holster = equippedTool.get_parent()
	#tool now in hand
	equippedTool.reparent(%carryingTransform, false)

## updates the player animation to face a certain direction (ie mouse location/carrying transform)
func updateAnimation():
	#find offset
	var offset:Vector2 = (carrying_transform.global_position - global_position)
	#flip y b/c weird
	offset.y = -offset.y
	var angleFromPlayer:float = offset.angle()
	#print(angleFromPlayer)
	#print(carrying_transform.global_position - global_position)
	
	#in grid
	var possibleAngleRanges = [-3*PI/4, -PI/4, PI/4, 3*PI/4]
	var playerAnimations:Array[StringName] = ["walkDown", "walkRight", "walkUp", "walkLeft"]
	
	for i in range(playerAnimations.size()):
		#last one since 5*PI/4 == -3PI/4
		if i == playerAnimations.size() - 1:
			player_sprite.play(playerAnimations[playerAnimations.size() - 1])
			break
		
		#check if in bounds
		if angleFromPlayer > possibleAngleRanges[i] && angleFromPlayer < possibleAngleRanges[i + 1]:
			if player_sprite.animation != playerAnimations[i]:
				player_sprite.play(playerAnimations[i])
			break
	
	#moving or not
	if velocity != Vector2.ZERO:
		#check if playing to prevent reset over and over again
		if !player_sprite.is_playing():
			player_sprite.play()
	else:
		#to set to first frame
		player_sprite.frame = 0
		player_sprite.pause()

func _input(event):
	#for updateAnimation
	if event is InputEventMouseMotion:
		updateCarryPosition(event)
	#TEMP later add pause menu
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

## updates the transform of the carry
func updateCarryPosition(event:InputEventMouseMotion):
	#use previous mouse pos before set
	#FIXED weird thing where the wand can only move along a line
	#replicate by dragging the mouse in one direction at low screen size for a long time
	#FIXED changed Input.MOUSE_MODE_CONFINED_HIDDEN to Input.MOUSE_MODE_CAPTURED
	
	var changeInPosition = event.relative
	carrying_transform.global_position += changeInPosition
	
	#find offset
	var offset:Vector2 = carrying_transform.global_position - global_position
	#print(offset)
	
	#clamp if too long
	#TODO later have walls block it
	if offset.length() > maxReach:
		carrying_transform.global_position = offset.normalized() * maxReach + global_position
	
	#flip y b/c weird
	#WARNING MESSES WITH OFFSET VARIABLE
	offset.y = -offset.y
	var angleFromPlayer:float = offset.angle()
	#rotate tool away from player
	carrying_transform.rotation = -angleFromPlayer + PI/2
	
	#print(carrying_transform.global_position)

func slowPlayerMovement(delta):
	velocity = lerp(velocity, Vector2.ZERO, brakePower * delta)
	if velocity.length() < fullStopThreshold:
		velocity = Vector2.ZERO

func dash():
	var speed = velocity.length()
	
	if hasDebugMovement:
		speed += 100
	
	velocity = Vector2.UP.rotated(carrying_transform.global_rotation) * speed

func debugSteer():
	var speed = velocity.length()
	velocity = Vector2.UP.rotated(carrying_transform.global_rotation) * speed
