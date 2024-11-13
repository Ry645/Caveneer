extends Sprite2D


#TEMP later add bolt sprite
func use():
	shootBolt()

func shootBolt():
	var body:Node2D = %RayCast2D.get_collider()
	if body.has_method("takeDamage"):
		body.takeDamage()
