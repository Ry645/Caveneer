extends CharacterBody2D

func _ready():
	var animatedSprite:AnimatedSprite2D = $AnimatedSprite2D
	animatedSprite.play()

func takeDamage():
	# this before take damage so the death animation takes precedence
	hurtEffect()
	$healthSystem.takeDamage(1)

func die():
	for i in range(5):
		hurtEffect()
		$hurtEffectTimer.start(0.06)
		await $hurtEffectTimer.timeout
		$hurtEffectTimer.start(0.06)
		await $hurtEffectTimer.timeout
	
	queue_free()

func hurtEffect():
	$AnimatedSprite2D.material.set_shader_parameter("tint", Color(0.5, 0.5, 0.5, 0))
	$hurtEffectTimer.start(0.15)

func endHurtEffect():
	$AnimatedSprite2D.material.set_shader_parameter("tint", Color(0, 0, 0, 0))
