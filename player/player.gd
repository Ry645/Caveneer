extends CharacterBody2D


@export var speed = 128
@export var maxReach = 40

@onready var player_sprite = %playerSprite
@onready var wand_transform = %wandTransform
@onready var wand = %wand

var previousMousePos:Vector2

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	pass

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	handleMovement(direction)
	inputProcess()
	updateAnimation(direction)

	move_and_slide()

func handleMovement(direction):
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

func inputProcess():
	if Input.is_action_just_pressed("interact"):
		pass

func updateAnimation(direction):
	#find offset
	var offset:Vector2 = (wand_transform.global_position - global_position)
	#flip y b/c weird
	offset.y = -offset.y
	var angleFromPlayer:float = offset.angle()
	#print(angleFromPlayer)
	#print(wand_transform.global_position - global_position)
	
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
	if direction:
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
		updateWandPosition(event)

func updateWandPosition(event:InputEventMouseMotion):
	var changeInPosition = event.global_position - previousMousePos
	previousMousePos = event.global_position
	
	wand_transform.global_position += changeInPosition
	
	#find offset
	var offset:Vector2 = wand_transform.global_position - global_position
	print(offset)
	
	#clamp if too long
	if offset.length() > maxReach:
		wand_transform.global_position = offset.normalized() * maxReach + global_position
	
	#flip y b/c weird
	#WARNING MESSES WITH offset VARIABLE
	offset.y = -offset.y
	var angleFromPlayer:float = offset.angle()
	wand_transform.rotation = -angleFromPlayer + PI/2
	
	#print(wand_transform.global_position)
