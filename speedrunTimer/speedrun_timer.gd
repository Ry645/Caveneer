extends Control


func _ready() -> void:
	if !GameGlobal.speedrunTimerEnabled:
		visible = false
	else:
		visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !GameGlobal.speedrunTimerEnabled:
		return
	
	updateTimer($level)
	updateTimer($game)

func updateTimer(label:RichTextLabel):
	var rawTime:float = GameGlobal.timeInGame
	var millisecondTime:int = RankData.secToMilliTime(rawTime)
	label.text = RankData.milliToClockTime(millisecondTime)
