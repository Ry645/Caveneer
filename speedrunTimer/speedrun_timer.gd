extends Control


func _ready() -> void:
	if !GameGlobal.speedrunTimer:
		visible = false
	else:
		visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !GameGlobal.speedrunTimer:
		return
	
	updateTimer($level)
	updateTimer($game)

func updateTimer(label:RichTextLabel):
	var rawTime:float = GameGlobal.timeInLevel
	var stringTime:String = str(rawTime)
	
	var stringToShow:String
	var minutes = int(rawTime / 60)
	if minutes < 10:
		stringToShow += "0"
	stringToShow += str(minutes)
	
	stringToShow += ":"
	
	var seconds = int(rawTime) % 60
	if seconds < 10:
		stringToShow += "0"
	stringToShow += str(seconds)
	
	stringToShow += "."
	
	var milliseconds = int((rawTime - float(int(rawTime))) * 1000)
	#print(milliseconds)
	if milliseconds < 100:
		stringToShow += "0"
	if milliseconds < 10:
		stringToShow += "0"
	
	stringToShow += str(milliseconds)
	
	label.text = stringToShow
