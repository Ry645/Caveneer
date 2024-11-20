extends AnimatedSprite2D

@export var hasDebugMovement:bool = false

@export var user:CharacterBody2D
@export var lineTexture:Texture2D = preload("res://sprites/grappleLash/grappleLine.png")

@export var grappleAcceleration = 128

@onready var grapple_range:RayCast2D = $grappleRange

enum {
	NOT_GRAPPLING,
	GRAPPLING,
	BUFFERING
}

var line:Line2D
var endpoint:Vector2
var grappleState:int = NOT_GRAPPLING


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if line != null:
		line.points[0] = grapple_range.global_position
	if grappleState == GRAPPLING:
		moveUser(delta)


func use():
	shootGrapple()

func shootGrapple():
	if line != null:
		stopUse()
	
	var desiredLocation = grapple_range.get_collision_point()
	if !grapple_range.is_colliding():
		desiredLocation = grapple_range.global_position
	
	if hasDebugMovement:
		desiredLocation = user.global_position
		desiredLocation += grapple_range.target_position.rotated(global_rotation)
	
	createGrappleLine(desiredLocation)
	
	grappleState = GRAPPLING

func createGrappleLine(desiredLocation):
	play("grapple")
	endpoint = desiredLocation
	#endpoint < 5
	line = Line2D.new()
	line.points = [grapple_range.global_position, endpoint]
	line.width = 1
	line.texture = lineTexture
	get_node("/root").get_child(1).add_child(line)
	#print(get_node("/root").get_child(0))

func moveUser(delta):
	#use grapple range instead of user for max control
	var maxLineLength := (endpoint - grapple_range.global_position).length()
	var direction := (endpoint - grapple_range.global_position).normalized()
	
	#var newPossibleGrappleLength:float = (endpoint - ((direction * grappleAcceleration * delta) + grapple_range.global_position + user.velocity)).length()
	
	var addedVelocity:Vector2 = direction * grappleAcceleration * delta
	#if newPossibleGrappleLength > maxLineLength:
		#addedVelocity *= 3
	
	user.velocity += addedVelocity

func stopUse():
	retractGrapple()
	if line != null:
		line.queue_free()

func retractGrapple():
	play("default")
	grappleState = NOT_GRAPPLING
