class_name GameController
extends Node2D

const GRID_WIDTH: int = 10 
const GRID_HEIGHT: int = 20

var grid: Array[Array] = []
var active_piece: Array[Vector2i] = []

@onready var game_area: TileMapLayer = $GameArea

@export var default_pieces : Array[Tetromino]

enum tetrominoes { 
	i_piece = 0,
	s_piece = 1,
	j_piece = 2,
	t_piece = 3,
	o_piece = 4,
	l_piece = 5,
	z_piece = 6,
}

func _init() -> void:
	grid.resize(GRID_WIDTH)
	for x in range(GRID_WIDTH):
		var arr = Array()
		for y in range(GRID_HEIGHT): 
			arr.append(8)
		grid[x] = arr
	return

func _process(delta: float) -> void:
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			var coord = Vector2i(x, y)
			var atlas = Vector2i(grid[x][y], 0)
			game_area.set_cell(coord, 1, atlas)
	return

func draw_tile(pos: Vector2i, atlas: int) -> void:
	if grid.size() > 0:
		if grid[pos.x].size() > 0:
			grid[pos.x][pos.y] = atlas
	return

func draw_piece(pos: Vector2i, rot: int, piece: tetrominoes) -> void: 
	var tiles = calculate_piece_data(pos, rot, piece)
	var atlas = tiles.pop_back()
	for tile in tiles: 
		draw_tile(tile, atlas.x)
	return

func draw_active_piece(pos: Vector2i, rot: int, piece:tetrominoes) -> void: 
	var tiles = calculate_piece_data(pos, rot, piece)
	var atlas = tiles.pop_back()
	
	for active in active_piece:
		draw_tile(active, 8)

	active_piece.clear()
	
	for tile in tiles: 
		draw_tile(tile, atlas.x)
		active_piece.append(tile)

	return

func calculate_piece_data(pos: Vector2i, rot: int, piece: tetrominoes) -> Array[Vector2i]:
	var piece_data = default_pieces[piece]
	var tiles = piece_data.get_piece_tiles(rot)
	var results: Array[Vector2i] = []
	for i in tiles:
		results.append(pos + i)
	var atlas = Vector2i(piece_data.piece_atlas, 0)
	results.append(atlas)
	return results
