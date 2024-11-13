extends CharacterBody2D

var hurtEffectFramesLeft = -1

func _ready():
	var animatedSprite:AnimatedSprite2D = $AnimatedSprite2D
	animatedSprite.play()

## for hurt effect frames
func _process(delta):
	processHurtEffect()

func processHurtEffect():
	if hurtEffectFramesLeft > 0:
		hurtEffectFramesLeft -= 1
	if hurtEffectFramesLeft == 0:
		hurtEffectFramesLeft -= 1
		endHurtEffect()

func takeDamage():
	$healthSystem.takeDamage(1)
	hurtEffect(20)

func die():
	print("ow")
	queue_free()

func hurtEffect(frames):
	$AnimatedSprite2D.material.set_shader_parameter("tint", Color(0.5, 0.5, 0.5, 0))
	hurtEffectFramesLeft = frames

func endHurtEffect():
	$AnimatedSprite2D.material.set_shader_parameter("tint", Color(0, 0, 0, 0))
