@tool

## will automatically create decor tiles given a base tile map layer
extends TileMapLayer

@export var scattering:int = 100
@export var generate:bool = false
@export var rawTileData:TileMapDual
@export var active:bool = false

var groundLayer:TileMapLayer

const ALL_ATLAS_COORDS:Array[Vector2i] = [
	Vector2i(0, 0),
	Vector2i(1, 0),
	Vector2i(2, 0),
	Vector2i(3, 0),
	Vector2i(0, 1),
	Vector2i(1, 1),
	Vector2i(3, 1),
	Vector2i(0, 2),
	Vector2i(2, 2),
	Vector2i(3, 2),
	Vector2i(2, 3),
	Vector2i(3, 3),
]


func _ready() -> void:
	if Engine.is_editor_hint():
		print("auto decor ready")
		set_process(true)
	else:
		set_process(false)

func _process(delta: float) -> void:
	if !active:
		return
	
	if groundLayer == null:
		groundLayer = rawTileData.display_tilemap
	
	if !generate:
		return
	
	generate = false
	
	call_deferred("updateDecor")

func updateDecor() -> void:
	var usedCellCoords := rawTileData.get_used_cells()
	
	for cellCoord in usedCellCoords:
		if randi_range(0, scattering - 1) == 0:
			setRandomDecorTile(cellCoord)
	
	notify_runtime_tile_data_update()

func setRandomDecorTile(coords:Vector2i):
	var index:int = randi_range(0, ALL_ATLAS_COORDS.size() - 1)
	var atlasCoord:Vector2i = ALL_ATLAS_COORDS[index]
	set_cell(coords + Vector2i(0, 0), 1, atlasCoord)
