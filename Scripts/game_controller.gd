class_name GameControler
extends Node2D


@onready var game_board: GameBoard = $GameBoard

# default values
var defaultSpawn: Vector2i = Vector2i(4, 3)
var defaultTetrominoBag: Array[Enums.tetrominoes] = [
	Enums.tetrominoes.i_piece,
	Enums.tetrominoes.s_piece,
	Enums.tetrominoes.j_piece,
	Enums.tetrominoes.t_piece,
	Enums.tetrominoes.o_piece,
	Enums.tetrominoes.l_piece,
	Enums.tetrominoes.z_piece,
]

# values for the active pieces
var active_piece: Enums.tetrominoes = Enums.tetrominoes.i_piece
var pos: Vector2i = defaultSpawn
var rot: int = 0

func _process(delta: float) -> void:
	game_board.draw_active_piece(
		pos,
		rot,
		active_piece
	)

func process_input(move: Enums.Direction, rotate: Enums.Direction) -> void: 
	piece_move(move)
	piece_rotate(rotate)
	return

func piece_move(dir: Enums.Direction) -> void: 
	
	return

func piece_rotate(dir: Enums.Direction) -> void: 
	rot += dir
	rot = posmod(rot, 4) 
	return
