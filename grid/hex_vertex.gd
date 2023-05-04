class_name HexVertex extends Node2D

var cells: Array = []

func _init(pos: Vector2):
	position = pos

func add_cell(cell_) -> void:
	for cell in cells:
		if cell == cell_:
			return

	cells.append(cell_)
