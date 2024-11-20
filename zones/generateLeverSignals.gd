@tool
extends Node2D

## INFO
## make sure each lever manager is numbered 1-x in coorespondence to the lever before and after nodes
## if the signal connection doesn't generate, look at your node names first when debugging

@export var generate:bool = false

#func _ready() -> void:
	#generateLeverSignals()

func _process(delta: float) -> void:
	if !generate:
		return
	
	generate = false
	generateLeverSignals()

func generateLeverSignals():
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
		
		if leverBeforeIndex < leverBefores.size():
			endCharacter = getEndingCharacter(leverBefores[leverBeforeIndex])
			if int(endCharacter) == managerNumber:
				print("wahoo")
				leverManagers[i].connect("setState", Callable(leverBefores[leverBeforeIndex], "setState"), CONNECT_PERSIST)
				leverBeforeIndex += 1
		
		if leverAfterIndex < leverAfters.size():
			endCharacter = getEndingCharacter(leverAfters[leverAfterIndex])
			if int(endCharacter) == managerNumber:
				print("wahoo")
				leverManagers[i].connect("setState", Callable(leverAfters[leverAfterIndex], "setState"), CONNECT_PERSIST)
				leverAfterIndex += 1

func getEndingCharacter(node:Node):
	return node.name.substr(node.name.length() - 1)

func sortViaNumber(array:Array):
	array.sort_custom(compareNodesViaNameNumber)

func compareNodesViaNameNumber(a:Node, b:Node):
	return int(getEndingCharacter(a)) < int(getEndingCharacter(b))
