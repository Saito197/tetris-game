class_name GameBoard
extends Node2D

const GRID_WIDTH: int = 10 
const GRID_HEIGHT: int = 22

var grid: Array[Array] = []
var active_piece: Array[Vector2i] = []

@onready var game_area: TileMapLayer = $GameArea

@export var default_pieces : Array[Tetromino]

func _init() -> void:
	grid.resize(GRID_WIDTH)
	for x in range(GRID_WIDTH):
		var arr = Array()
		for y in range(GRID_HEIGHT): 
			arr.append(8)
		grid[x] = arr
	return

func _ready() -> void:
	for p in default_pieces:
		p.calculate_piece_movement_offsets()
	
func _process(delta: float) -> void:
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			var coord = Vector2i(x, y)
			var atlas = Vector2i(grid[x][y], 0)
			game_area.set_cell(coord, 1, atlas)
	return

# Drawing individual tile
func draw_tile(pos: Vector2i, atlas: int) -> void:
	if grid.size() > 0:
		if grid[pos.x].size() > 0:
			grid[pos.x][pos.y] = atlas
	return

# Static/locked pieces
func draw_piece(pos: Vector2i, rot: int, piece: Enums.tetrominoes) -> void: 
	var tiles = calculate_piece_data(pos, rot, piece)
	var atlas = tiles.pop_back()
	for tile in tiles: 
		draw_tile(tile, atlas.x)
	return

# Active pieces are cleared before being re-drawn
func draw_active_piece(pos: Vector2i, rot: int, piece: Enums.tetrominoes) -> void: 
	var tiles = calculate_piece_data(pos, rot, piece)
	var atlas = tiles.pop_back()
	
	for active in active_piece:
		draw_tile(active, 8)

	active_piece.clear()
	
	for tile in tiles: 
		draw_tile(tile, atlas.x)
		active_piece.append(tile)

	return

# returns an array of 5 Vector2i, 
# 4 for tile position data and 1 for the piece's atlas/color
func calculate_piece_data(pos: Vector2i, rot: int, piece: Enums.tetrominoes) -> Array[Vector2i]:
	var piece_data = default_pieces[piece]
	var tiles = piece_data.get_piece_tiles(rot)
	var results: Array[Vector2i] = []
	for i in tiles:
		results.append(pos + i)
	var atlas = Vector2i(piece_data.piece_atlas, 0)
	results.append(atlas)
	return results
