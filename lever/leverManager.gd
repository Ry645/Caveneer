class_name LeverManager
extends Node2D

@export var quickPuzzle:bool = false

var numLevers:int
var pulledLevers:int

## DEPRECATED
signal activate
## DEPRECATED
signal deactivate

signal setState(state:int)

# Called when the node enters the scene tree for the first time.
func _ready():
	numLevers = get_children().size()


func activatedLever():
	pulledLevers += 1
	if pulledLevers == numLevers || quickPuzzle:
		emit_signal("activate")
		emit_signal("setState", 1)

func deactivatedLever():
	if pulledLevers == numLevers || quickPuzzle:
		emit_signal("deactivate")
		emit_signal("setState", 0)
	pulledLevers -= 1

func enable():
	for child in get_children():
		child.enable()

func disable():
	for child in get_children():
		child.disable()
