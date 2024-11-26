extends AnimatedSprite2D

var a:int = 1


func _on_timeout_timer() -> void:
	position.y += a
	a *= -1

func showOutline():
	material.set_shader_parameter("process", true)

func hideOutline():
	material.set_shader_parameter("process", false)
