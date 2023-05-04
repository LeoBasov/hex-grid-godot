class_name HexGrid extends Node2D

@export var size: float = 100.0
var cell_map: Array[Array]
var n_circle: int

func _draw():
	for child in get_children():
		draw_circle(child.position, 10.0, Color.GREEN)
		
		for i in range(1, 6):
			draw_line(child.pointy_hex_corner(size, i - 1), child.pointy_hex_corner(size, i), Color.RED)

func build(n_circle_: int) -> void:
	var cell
	n_circle = n_circle_
	
	for q in range(-n_circle, n_circle + 1):
		cell_map.append([])
		
		for r in range(-n_circle, n_circle + 1):
			cell_map[q + n_circle].append(null)
	
	for q in range(-n_circle, n_circle + 1):
		for r in range(-n_circle, n_circle + 1):
			if abs(q + r) <= n_circle:
				cell = HexCell.new(r, q, size)
				add_child(cell)
				cell.owner = self
				cell_map[q + n_circle][r + n_circle] = cell
