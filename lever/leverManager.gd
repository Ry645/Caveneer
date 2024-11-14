extends Node2D

@export var quickPuzzle:bool# = true

var numLevers:int
var pulledLevers:int

signal activate

# Called when the node enters the scene tree for the first time.
func _ready():
	numLevers = get_children().size()


func pulledLever():
	pulledLevers += 1
	if pulledLevers == numLevers || quickPuzzle:
		emit_signal("activate")

func enable():
	for child in get_children():
		child.enable()
