@tool

## will automatically create a border given a base tile map layer
class_name AutoBorder
extends TileMapLayer


## directly associated with ALL_BORDER_OFFSETS
## represents a tile in the standard godot tileset
## the empty tile is omitted (0, 3)
## the non-edge tile is also omitted (2, 1)
const ALL_ATLAS_COORDS:Dictionary = {
	0: Vector2i(0, 0),
	1: Vector2i(1, 0),
	2: Vector2i(2, 0),
	3: Vector2i(3, 0),
	4: Vector2i(0, 1),
	5: Vector2i(1, 1),
	6: Vector2i(2, 1),
	7: Vector2i(3, 1),
	8: Vector2i(0, 2),
	9: Vector2i(1, 2),
	10: Vector2i(2, 2),
	11: Vector2i(3, 2),
	12: Vector2i(1, 3),
	13: Vector2i(2, 3),
	14: Vector2i(3, 3),
}

## directly associated with ALL_ATLAS_COORDS
## offsets the new border tile according to ALL_ATLAS_COORDS index
## multiply by tile width to use the offset
## null entries should be handled on a case-by-case basis, since they have special properties
## for example: requiring to have 2 tiles placed
var ALL_BORDER_OFFSETS:Dictionary = {
	0: Vector2i(1, -1),
	1: Vector2i(-1, 0),
	2: Vector2i(1, -1),
	3: Vector2i(0, -1),
	4: null,
	5: Vector2i(-1, -1),
	6: null,
	7: Vector2i(1, 1),
	8: Vector2i(-1, 1),
	9: Vector2i(0, 1),
	10: Vector2i(-1, 1),
	11: Vector2i(1, 0),
	12: Vector2i(-1, -1),
	13: null,
	14: Vector2i(1, 1),
}


"""
steps:
	1:
		get all tiles of the "edge" type
		use: get_cell_atlas_coords
	2:
		add a void tile based on what edge type it is
	3:
		get all border tiles
		find which border tiles overlap with cave floor and erase them
"""
@export var rawTileData:TileMapDual
var groundLayer:TileMapLayer

func _ready() -> void:
	if Engine.is_editor_hint():
		print("auto border ready")
		set_process(true)
	else:
		set_process(false)

func _process(delta: float) -> void:
	if groundLayer == null:
		groundLayer = rawTileData.display_tilemap
	
	call_deferred("updateBorder")

func updateBorder() -> void:
	var usedCellCoords := groundLayer.get_used_cells()
	
	for cellCoord in usedCellCoords:
		var cellAtlasCoord = groundLayer.get_cell_atlas_coords(cellCoord)
		var index = ALL_ATLAS_COORDS.find_key(cellAtlasCoord)
		match index:
			4:
				setBorderTile(cellCoord, Vector2i(1, -1))
				setBorderTile(cellCoord, Vector2i(-1, 1))
				continue
			6:
				print("no")
				continue
			13:
				setBorderTile(cellCoord, Vector2i(-1, -1))
				setBorderTile(cellCoord, Vector2i(1, 1))
				continue
		
		setBorderTile(cellCoord, ALL_BORDER_OFFSETS[index])
		
		
		# if a border tile gets covered by a floor tile, erase the border tile
		if get_cell_source_id(cellCoord) != -1:
			erase_cell(cellCoord)
	
	
	notify_runtime_tile_data_update()

func setBorderTile(coords:Vector2i, offset:Vector2i):
	set_cell(coords + offset, 1, Vector2i(0, 0))
