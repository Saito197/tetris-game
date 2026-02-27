
class_name Tetromino
extends Resource

@export var piece_atlas: Enums.tetrominoes

@export var rot0: Array[Vector2i]
@export var rot90: Array[Vector2i]
@export var rot180: Array[Vector2i]
@export var rot270: Array[Vector2i]

@export var offsets: Array[Offset]

func get_piece_tiles(orientation: int) -> Array[Vector2i]:
	match orientation:
		1: 
			return rot90
		2:
			return rot180
		3:
			return rot270
		_: 
			return rot0

func calculate_piece_movement_offsets() -> void:
	offsets = []
	for i in range(4):
		var tiles = get_piece_tiles(i) 
		var offset = Offset.new()
		var min_x = {}
		var max_x = {}
		
		# Find the lowest and highest x values for each unique y position
		for tile in tiles:
			var x: int = tile.x
			var y: int = tile.y
			if min_x.has(tile.y):
				min_x[y] = x - 1 if x - 1 < min_x[y] else min_x[y]
			else: 
				min_x[y] = x - 1
			
			if max_x.has(tile.y):
				max_x[y] = x + 1 if x + 1 > max_x[y] else max_x[y]
			else: 
				max_x[y] = x + 1

		# Assigning them back into Vectors
		offset.CollisionL = convert_dict_to_vectors(min_x)
		offset.CollisionR = convert_dict_to_vectors(max_x)
		offsets.append(offset) 
	return

func convert_dict_to_vectors(values: Dictionary) -> Array[Vector2i]:
	var results: Array[Vector2i] = []
	for y in values:
		results.append(Vector2i(values[y], y))
	return results
