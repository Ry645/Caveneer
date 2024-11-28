extends Node

# I finished the game in 06:07.903

# 324/0.9/0.8/0.7

## in milliseconds
const timeToRank:Dictionary = {
	260_000: "F",
	300_000: "S",
	360_000: "A",
	450_000: "B",
	640_000: "C",
	-1: "D",
}

## in milliseconds
func getRankFromTime(time:int) -> String:
	for key in timeToRank.keys():
		if time < key:
			return timeToRank[key]
	return timeToRank[-1]

## converts seconds to milliseconds
func secToMilliTime(a:float) -> int:
	return int(a * 1000.0)


func milliToClockTime(rawTime:int) -> String:
	var stringToShow:String
	var minutes = rawTime / 1000 / 60
	if minutes < 10:
		stringToShow += "0"
	stringToShow += str(minutes)
	
	stringToShow += ":"
	
	var seconds = (rawTime / 1000) % 60
	if seconds < 10:
		stringToShow += "0"
	stringToShow += str(seconds)
	
	stringToShow += "."
	
	var milliseconds = rawTime % 1000
	#print(milliseconds)
	if milliseconds < 100:
		stringToShow += "0"
	if milliseconds < 10:
		stringToShow += "0"
	stringToShow += str(milliseconds)
	
	return stringToShow
