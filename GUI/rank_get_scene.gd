extends Control

var screens:Array[Node]
var index:int = 0

func _ready() -> void:
	#print("poot")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	screens = get_tree().get_nodes_in_group("screen")
	
	for screen in screens:
		screen.visible = false
	screens[0].visible = true

func advance():
	screens[index].queue_free()
	if index < screens.size() - 1:
		screens[index + 1].visible = true
	else:
		GameGlobal.loadTitleScreen()
	index += 1
