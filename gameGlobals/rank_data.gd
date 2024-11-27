extends Node

# I finished the game in 06:07.903

## in milliseconds
const timeToRank:Dictionary = {
	320_000: "S",
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
