extends Node

func doorOpen():
	$doorOpen.play()

func doorImportantOpen():
	$doorImportantOpen.play()

func stopAmbience():
	$ambience.stop()

func playAmbience():
	$ambience.play()
