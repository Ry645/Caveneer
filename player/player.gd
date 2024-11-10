extends CharacterBody2D


@export var speed = 128
@onready var player_sprite = %playerSprite

var mousePos:Vector2

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	handleMovement(direction)
	
	updateAnimation(direction)

	move_and_slide()

func handleMovement(direction):
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

func updateAnimation(direction):
	var offset:Vector2 = (mousePos - global_position)
	#flip y b/c weird
	offset.y = -offset.y
	var angleFromPlayer:float = offset.angle()
	print(angleFromPlayer)
	#print(mousePos - global_position)
	
	var possibleAngleRanges = [-3*PI/4, -PI/4, PI/4, 3*PI/4]
	var playerAnimations:Array[StringName] = ["walkDown", "walkRight", "walkUp", "walkLeft"]
	
	for i in range(playerAnimations.size()):
		if i == playerAnimations.size() - 1:
			player_sprite.play(playerAnimations[playerAnimations.size() - 1])
			break
		
		if angleFromPlayer > possibleAngleRanges[i] && angleFromPlayer < possibleAngleRanges[i + 1]:
			if player_sprite.animation != playerAnimations[i]:
				player_sprite.play(playerAnimations[i])
			break
	
	if direction:
		if !player_sprite.is_playing():
			player_sprite.play()
	else:
		#to set to first frame
		player_sprite.frame = 0
		player_sprite.pause()

func _input(event):
	if event is InputEventMouseMotion:
		mousePos = event.global_position
