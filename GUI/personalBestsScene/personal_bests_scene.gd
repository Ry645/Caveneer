extends Control


@export var timeElement:PackedScene = preload("res://GUI/personalBestsScene/time_element.tscn")

func _ready() -> void:
	for time in GameGlobal.ms_times:
		var timeNode:TimeElement = timeElement.instantiate()
		timeNode.setTime(time)
		$panel/scrollContainer/vBoxContainer.add_child(timeNode)



func _on_button_up_back_button() -> void:
	GameGlobal.loadTitleScreen()
