extends Node

var screens:Array[Node]
var index:int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screens = get_tree().get_nodes_in_group("screen")
	
	for screen in screens:
		screen.visible = false
	screens[0].visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func advance():
	screens[index].hide()
	if index < screens.size() - 1:
		screens[index + 1].visible = true
	else:
		get_parent().lastAdvance()
	index += 1
