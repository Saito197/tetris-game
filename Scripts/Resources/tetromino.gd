
class_name Tetromino
extends Resource

@export var piece_atlas: Enums.tetrominoes

@export var rot0: Array[Vector2i]
@export var rot90: Array[Vector2i]
@export var rot180: Array[Vector2i]
@export var rot270: Array[Vector2i]

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
