extends Node


@export var gameCompleted:bool = false

@export var speedrunTimer:bool = false
@export var magicShield:bool = false
@export var rank:bool = false

@export var timer:PackedScene = preload("res://speedrunTimer/speedrun_timer.tscn")

@export var debugMode:bool = false

var timeInGame:float = 0.0
var timeInLevel:float = 0.0


func unlockEverything():
	gameCompleted = true
	speedrunTimer = true
	magicShield = true
	rank = true

func _process(delta: float) -> void:
	timeInGame += delta
	timeInLevel += delta
	

## loads area and adds a speedrun timer
func loadArea(sceneToLoad:PackedScene):
	get_node("/root").get_tree().change_scene_to_packed(sceneToLoad)
	var canvas = CanvasLayer.new()
	canvas.add_child(timer.instantiate())
	get_node("/root").add_child(canvas)
