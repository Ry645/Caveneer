extends AnimatedSprite2D

@export var user:CharacterBody2D
@export var lineTexture:Texture2D = preload("res://sprites/grappleLash/grappleLine.png")

@export var grappleAcceleration = 128

@onready var grapple_range:RayCast2D = $grappleRange

var line:Line2D
var endpoint:Vector2
var isGrappling:bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if line != null:
		line.points[0] = grapple_range.global_position
	if isGrappling:
		moveUser(delta)


func use():
	shootGrapple()

func shootGrapple():
	if !grapple_range.is_colliding():
		return
	
	createGrappleLine()
	
	isGrappling = true

func createGrappleLine():
	play("grapple")
	endpoint = grapple_range.get_collision_point()
	#endpoint < 5
	line = Line2D.new()
	line.points = [grapple_range.global_position, endpoint]
	line.width = 1
	line.texture = lineTexture
	get_node("/root").get_child(1).add_child(line)
	#print(get_node("/root").get_child(0))

func moveUser(delta):
	#use grapple range instead of user for max control
	var direction = (endpoint - grapple_range.global_position).normalized()
	user.velocity += direction * grappleAcceleration * delta

func stopUse():
	retractGrapple()
	if line != null:
		line.queue_free()

func retractGrapple():
	play("default")
	isGrappling = false
