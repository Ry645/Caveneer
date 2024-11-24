extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func use():
	$activeSound.volume_db = -3
	$activeSound.play()
	$timeActive.start()
	visible = true
	play("active")
	await get_tree().create_timer(0.1).timeout
	$activeSound.volume_db = -15


func _on_timeout() -> void:
	$activeSound.stop()
	stop()
	visible = false
