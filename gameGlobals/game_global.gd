extends Node


@export var speedrunUnlocked:bool = false

@export var speedrunTimer:bool = false
@export var magicShield:bool = false
@export var rank:bool = false

var timeInGame:float = 0.0
var timeInLevel:float = 0.0


func unlockEverything():
	speedrunUnlocked = true
	speedrunTimer = true
	magicShield = true
	rank = true

func _process(delta: float) -> void:
	timeInGame += delta
	timeInLevel += delta
	
