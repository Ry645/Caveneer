extends HBoxContainer
class_name TimeElement

var time:int
var rank:String

func _init(time) -> void:
	if time is float:
		self.time = RankData.secToMilliTime(time)
	elif time is int:
		self.time = time
	
	
