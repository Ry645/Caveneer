extends Node


@export var speedrunUnlocked:bool = false

@export var speedrunTimer:bool = false
@export var magicShield:bool = false
@export var rank:bool = false




func unlockEverything():
	speedrunUnlocked = true
	speedrunTimer = true
	magicShield = true
	rank = true
