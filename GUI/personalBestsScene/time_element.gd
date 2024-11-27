extends HBoxContainer
class_name TimeElement

var time:int
var rank:String

func setTime(time) -> void:
	if time is float:
		self.time = RankData.secToMilliTime(time)
	elif time is int:
		self.time = time

func _ready() -> void:
	$time.text = RankData.milliToClockTime(time)
	$rank.text = RankData.getRankFromTime(time)
