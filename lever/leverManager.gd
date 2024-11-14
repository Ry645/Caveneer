extends Node

var numLevers:int
var pulledLevers:int

signal activate

# Called when the node enters the scene tree for the first time.
func _ready():
	numLevers = get_children().size()


func pulledLever():
	numLevers += 1
	if pulledLevers == numLevers:
		emit_signal("activate")
