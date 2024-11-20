@tool
extends Node2D

## INFO
## make sure each lever manager is numbered 1-x in coorespondence to the lever before and after nodes
## if the signal connection doesn't generate, look at your node names first when debugging

## naming convention: node6A, node6B

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
	
	## DEPRECATED
	var leverBefores := get_tree().get_nodes_in_group("leverBefore");
	sortViaNumber(leverBefores)
	
	## DEPRECATED
	var leverAfters := get_tree().get_nodes_in_group("leverAfter");
	sortViaNumber(leverAfters)
	
	var toggleAreas := get_tree().get_nodes_in_group("toggleArea")
	sortViaNumber(toggleAreas)
	
	var leverBeforeIndex:int = 0
	var leverAfterIndex:int = 0
	
	var toggleAreaIndex:int = 0
	for i in range(leverManagers.size()):
		var managerNumber = getNodeNumber(leverManagers[i])
		
		## DEPRECATED
		if leverBeforeIndex < leverBefores.size():
			if getNodeNumber(leverBefores[leverBeforeIndex]) == managerNumber:
				print("leverBefore", leverBeforeIndex)
				leverManagers[i].connect("setState", Callable(leverBefores[leverBeforeIndex], "setState"), CONNECT_PERSIST)
				leverBeforeIndex += 1
		
		## DEPRECATED
		if leverAfterIndex < leverAfters.size():
			if getNodeNumber(leverAfters[leverAfterIndex]) == managerNumber:
				print("leverAfter", leverAfterIndex)
				leverManagers[i].connect("setState", Callable(leverAfters[leverAfterIndex], "setState"), CONNECT_PERSIST)
				leverAfterIndex += 1
		
		
		if toggleAreaIndex < toggleAreas.size():
			while getNodeNumber(toggleAreas[toggleAreaIndex]) == managerNumber:
				print("toggleArea", toggleAreaIndex)
				leverManagers[i].connect("setState", Callable(toggleAreas[toggleAreaIndex], "toggle"), CONNECT_PERSIST)
				toggleAreaIndex += 1

func getEndingCharacter(node:Node):
	return node.name.substr(node.name.length() - 1)

func sortViaNumber(array:Array):
	array.sort_custom(compareNodesViaNumber)

func compareNodesViaNumber(a:Node, b:Node):
	return a.name.to_int() < b.name.to_int()

func getNodeNumber(node:Node):
	return node.name.to_int()
