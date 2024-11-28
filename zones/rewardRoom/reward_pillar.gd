extends AnimatedSprite2D

@export var sceneToLoad:PackedScene = preload("res://zones/rewardRoom/rewardExplain.tscn")

func _ready() -> void:
	play()

func loadArea():
	GameGlobal.loadUI(sceneToLoad)

func interact():
	GameGlobal.gameTimeRunning = false
	GameGlobal.ms_times.append(RankData.secToMilliTime(GameGlobal.timeInGame))
	GameGlobal.save_game()
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
