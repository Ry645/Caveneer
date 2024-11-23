extends Area2D


func _on_body_entered(body: Node2D) -> void:
	call_deferred("wallKickCollision")

func wallKickCollision():
	get_parent().wallKickCollision()
