class_name LeverManager
extends Node2D

@export var quickPuzzle:bool# = true

var numLevers:int
var pulledLevers:int

signal activate
signal deactivate

# Called when the node enters the scene tree for the first time.
func _ready():
	numLevers = get_children().size()


func activatedLever():
	pulledLevers += 1
	if pulledLevers == numLevers || quickPuzzle:
		emit_signal("activate")

func deactivatedLever():
	if pulledLevers == numLevers || quickPuzzle:
		emit_signal("deactivate")
	pulledLevers -= 1

func enable():
	for child in get_children():
		child.enable()
