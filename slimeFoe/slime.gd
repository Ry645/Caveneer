extends CharacterBody2D

func _ready():
	var animatedSprite:AnimatedSprite2D = $AnimatedSprite2D
	animatedSprite.play()

func takeDamage():
	$healthSystem.takeDamage(1)

func die():
	print("ow")
	queue_free()
