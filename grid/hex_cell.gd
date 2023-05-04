class_name HexCell extends Node2D

var q: int
var r: int
var vertices: Array

func _init(q_: int, r_: int, size: float):
	q = q_
	r = r_

	position.x += sqrt(3) * size * r + 0.5 * sqrt(3) * size * q
	position.y -= (3.0/2.0) * size * q
	
	vertices.resize(6)
	
	for i in range(6):
		vertices[i] = null

func pointy_hex_corner(size, i):
	var angle_deg = -60 * i - 30
	var angle_rad = PI / 180 * angle_deg
	return Vector2(position.x + size * cos(angle_rad), position.y + size * sin(angle_rad))
