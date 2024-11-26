extends AnimatedSprite2D

@export var sceneToLoad:PackedScene = preload("res://zones/rewardRoom/rewardExplain.tscn")

func _ready() -> void:
	play()

func loadArea():
	get_node("/root").get_tree().change_scene_to_packed(sceneToLoad)

func interact():
	loadArea()
	return 0

func hover():
	showOutline()
	await get_tree().physics_frame
	hideOutline()

func showOutline():
	$magicShieldGet.showOutline()
	#material.set_shader_parameter("process", true)

func hideOutline():
	$magicShieldGet.hideOutline()
	#material.set_shader_parameter("process", false)