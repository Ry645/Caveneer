extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = RankData.getRankFromTime(RankData.secToMilliTime(GameGlobal.timeInGame))
