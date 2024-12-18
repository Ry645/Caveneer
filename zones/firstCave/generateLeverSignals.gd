@tool
extends Node2D

## INFO
## make sure each lever manager is numbered 1-x in coorespondence to the lever before and after nodes
## if the signal connection doesn't generate, look at your node names first when debugging

## naming convention: node6, node6_2
## WARNING: DO NOT USE ZERO

## just click generate twice idk why it does that
## reopen scene if not work

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
	#print(leverManagers)
	
	## DEPRECATED
	var leverBefores := get_tree().get_nodes_in_group("leverBefore");
	sortViaNumber(leverBefores)
	
	## DEPRECATED
	var leverAfters := get_tree().get_nodes_in_group("leverAfter");
	sortViaNumber(leverAfters)
	
	var toggleAreas := get_tree().get_nodes_in_group("toggleArea")
	sortViaNumber(toggleAreas)
	#print(toggleAreas)
	
	var doors := get_tree().get_nodes_in_group("door")
	sortViaNumber(doors)
	
	var leverBeforeIndex:int = 0
	var leverAfterIndex:int = 0
	
	var toggleAreaIndex:int = 0
	var doorIndex:int = 0
	for i in range(leverManagers.size()):
		var managerNumber = getNodeNumber(leverManagers[i])
		#print(managerNumber)
		
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
		
		while toggleAreaIndex < toggleAreas.size() && getNodeNumber(toggleAreas[toggleAreaIndex]) == 0:
			#print(toggleAreas[toggleAreaIndex])
			toggleAreaIndex += 1
		
		while toggleAreaIndex < toggleAreas.size() && getNodeNumber(toggleAreas[toggleAreaIndex]) == managerNumber:
			print("connected: ", toggleAreas[toggleAreaIndex])
			leverManagers[i].connect("setState", Callable(toggleAreas[toggleAreaIndex], "toggle"), CONNECT_PERSIST)
			toggleAreaIndex += 1
		
		
		# doors
		doorIndex = connectSignals(doorIndex, doors, managerNumber, leverManagers[i], "setState")
	
	## goes through all toggle areas and finds each manager number in the connectWith list
	for toggleArea:ToggleArea in toggleAreas:
		for num in toggleArea.connectWith:
			for manager in leverManagers:
				if getNodeNumber(manager) == num:
					manager.connect("setState", Callable(toggleArea, "toggle"), CONNECT_PERSIST)

func sortViaNumber(array:Array):
	array.sort_custom(compareNodesViaNumber)

func compareNodesViaNumber(a:Node, b:Node):
	return getNodeNumber(a) < getNodeNumber(b)

## ignores everything past the underscore
func getNodeNumber(node:Node):
	var nodeName = node.name.substr(0, node.name.find("_"))
	return nodeName.to_int()


func connectSignals(index:int, nodes:Array[Node], managerNumber:int, leverManager:Node, methodName:StringName):
	var newIndex = index
	while newIndex < nodes.size() && getNodeNumber(nodes[newIndex]) == 0:
		#print(nodes[newIndex])
		newIndex += 1
	
	while newIndex < nodes.size() && getNodeNumber(nodes[newIndex]) == managerNumber:
		print("connected: ", nodes[newIndex])
		leverManager.connect("setState", Callable(nodes[newIndex], methodName), CONNECT_PERSIST)
		newIndex += 1
	
	return newIndex
