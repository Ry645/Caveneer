class_name LeverManager
extends Node2D

@export var quickPuzzle:bool = false
@export var isImportant:bool = false

var numLevers:int
var pulledLevers:int

## DEPRECATED
signal activate
## DEPRECATED
signal deactivate

signal setState(state:int)

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.isImportant = isImportant
	
	numLevers = get_children().size()
	
	# to account for multiple togglable levers
	if get_child(0).isOneShot == false:
		numLevers = 1;

func syncChildren(state):
	# should only be levers
	for child in get_children():
		child.sync(state)

func activatedLever():
	playDoorSound()
	pulledLevers += 1
	syncChildren(1)
	if pulledLevers == numLevers || quickPuzzle:
		emit_signal("activate")
		emit_signal("setState", 1)

func deactivatedLever():
	playDoorSound()
	syncChildren(0)
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

func playDoorSound():
	if isImportant:
		await get_tree().create_timer(1000).timeout
		SoundFx.doorImportantOpen()
	else:
		SoundFx.doorOpen()
