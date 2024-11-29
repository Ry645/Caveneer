extends Control


"""
There it is.
That entrance.

This is the cave the world shuns.
Anyone who enters...

Never leaves.

And yet,
The cave beckons to me.

It promises a level of elation I cannot comprehend.
Infinite treasures, infinite challenges.

Almost as if it were sentient.

I can't verify those promises.
However...
"""
const firstTextArray:Array[String] = [
	"There it is.",
	"That entrance.\n",
	"This is the cave the world shuns.",
	"Anyone who enters...\n",
	"Never leaves.\n",
	"And yet,\nThe cave beckons to me.\n",
	"It promises a level of elation I cannot comprehend.",
	"Infinite treasures, infinite challenges.\n",
	"Almost as if it were sentient.\n",
	"I can't verify those promises.",
	"However..."
]



"""
I don't have much of my life left.

I've lost everything.
All but my trusty grappling hook.

And now, I only wonder.

What else can I lose?
My sanity?
My integrity?

Well...

Past the nebulous tunnel,

There's only one way to find out.
"""
const secondTextArray:Array[String] = [
	"I don't have much of my life left.\n",
	"I've lost everything.\nAll but my trusty grappling hook.\n",
	"And now, I only wonder.\n",
	"What else can I lose?",
	"My sanity?",
	"My integrity?\n",
	"Well...\n",
	"Past the nebulous tunnel,\n",
	"There's only one way to find out."
]

var index:int = 0
var currentArray:Array = firstTextArray
@onready var labelToUse := $introText1
var advanced:bool = false


## sets up the starting scene
func _ready() -> void:
	$introText1.text = ""
	$introText1.show()
	$introText2.text = ""
	$introText2.show()
	
	$advanceButton.visible = false
	$sprites.visible = false
	
	await get_tree().create_timer(4).timeout
	
	# show cave entrance
	$sprites.visible = true
	
	await get_tree().create_timer(4).timeout
	
	# hide cave entrance
	$sprites.visible = false
	
	await get_tree().create_timer(2).timeout
	
	# show button and start text
	$advanceButton.visible = true
	advanceText()


func advanceText():
	if index >= currentArray.size():
		if advanced:
			$advanceButton.disabled = true
			labelToUse.text = ""
			triggerFadeOut()
			return
		
		advanced = true
		index = 0
		currentArray = secondTextArray
		labelToUse.text = ""
		labelToUse = $introText2
	
	labelToUse.text = labelToUse.text + currentArray[index] + "\n"
	index += 1


func _on_button_up_default_button() -> void:
	advanceText()

func triggerFadeOut():
	# keep button alive
	await get_tree().create_timer(3).timeout
	
	# hide button
	$advanceButton.visible = false
	
	await get_tree().create_timer(3).timeout
	
	# start game
	GameGlobal.gameStarted = true
	GameGlobal.save_game()
	GameGlobal.loadFirstLevel()
	
