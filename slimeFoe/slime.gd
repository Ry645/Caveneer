extends CharacterBody2D

var health = 3

func takeDamage():
	health -= 1
	if health <= 0:
		die()

func die():
	print("ow")
	queue_free()
