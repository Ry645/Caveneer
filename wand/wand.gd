extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#TEMP
func use():
	shootBolt()

func shootBolt():
	var body:Node2D = %RayCast2D.get_collider()
	if body.has_method("takeDamage"):
		body.takeDamage()
