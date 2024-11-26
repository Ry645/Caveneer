extends Control

var screens:Array[Node] = [$screen1, $screen2]
var index:int = 0


func advance():
	screens[0].queue_free()
	index += 1


func _on_button_up_button() -> void:
	advance()
