class_name Door
extends TileMapLayer

func disable():
	enabled = false

func enable():
	enabled = true


func setState(state):
	enabled = !enabled
