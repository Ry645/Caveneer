extends Node2D

## INFO
## make sure each lever manager is numbered 1-x in coorespondence to the lever before and after nodes
## if the signal connection doesn't generate, look at your node names first when debugging

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	var leverManagers := get_tree().get_nodes_in_group("leverManager");
	sortViaNumber(leverManagers)
	
	var leverBefores := get_tree().get_nodes_in_group("leverBefore");
	sortViaNumber(leverBefores)
	
	var leverAfters := get_tree().get_nodes_in_group("leverAfter");
	sortViaNumber(leverAfters)
	
	var leverBeforeIndex:int = 0
	var leverAfterIndex:int = 0
	for i in range(leverManagers.size()):
		var endCharacter = getEndingCharacter(leverManagers[i])
		var managerNumber = int(endCharacter)
		
		endCharacter = getEndingCharacter(leverBefores[leverBeforeIndex])
		if int(endCharacter) == managerNumber:
			leverManagers[i].connect("setState", Callable(leverBefores[leverBeforeIndex], "setState"))
			leverBeforeIndex += 1
		
		endCharacter = getEndingCharacter(leverAfters[leverAfterIndex])
		if int(endCharacter) == managerNumber:
			leverManagers[i].connect("setState", Callable(leverAfters[leverAfterIndex], "setState"))
			leverAfterIndex += 1

func getEndingCharacter(node:Node):
	return node.name.substr(node.name.length() - 1)

func sortViaNumber(array:Array):
	array.sort_custom(compareNodesViaNameNumber)

func compareNodesViaNameNumber(a:Node, b:Node):
	return int(getEndingCharacter(a)) < int(getEndingCharacter(b))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
