class_name Door
extends TileMapLayer

@export var overrideEnabled:bool = false
@export var enabledOnReady:bool = false


func _ready() -> void:
	if overrideEnabled:
		enabled = enabledOnReady

func disable():
	enabled = false

func enable():
	enabled = true


func setState(state):
	enabled = !enabled
