extends Node

## saved on exit
@export var gameCompleted:bool = false
@export var speedrunTimerEnabled:bool = false
@export var magicShieldEnabled:bool = false
@export var rankEnabled:bool = false

#Array[int]
@export var ms_times:Dictionary = {
	"fullGame": [],
	"level1": [],
	"level2": [],
	"level3": [],
	"level4": [],
	"level5": [],
	"level6": [],
}

@export var currentLevel:int = 1
##

@export var timer:PackedScene = preload("res://speedrunTimer/speedrun_timer.tscn")
@export var debugMode:bool = false

var timeInGame:float = 0.0
var timeInLevel:float = 0.0


func unlockEverything():
	if gameCompleted:
		return
	
	gameCompleted = true
	speedrunTimerEnabled = true
	magicShieldEnabled = true
	rankEnabled = true

func _process(delta: float) -> void:
	timeInGame += delta
	timeInLevel += delta
	

## loads area and adds a speedrun timer
func loadArea(sceneToLoad:PackedScene):
	get_node("/root").get_tree().change_scene_to_packed(sceneToLoad)
	var canvas = CanvasLayer.new()
	canvas.add_child(timer.instantiate())
	get_node("/root").add_child(canvas)
