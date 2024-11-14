extends TileMap

var starting_position:Vector2

func _ready():
	starting_position = global_position

func disable():
	visible = false
	global_position = Vector2(-1000000, -1000000)

func enable():
	visible = true
	global_position = starting_position


