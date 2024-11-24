extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func use():
	$activeSound.play()
	$timeActive.start()
	visible = true
	play("active")


func _on_timeout() -> void:
	$activeSound.stop()
	stop()
	visible = false
