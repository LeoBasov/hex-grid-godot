class_name HexCell extends Node2D

var q: int
var r: int
var s:int:
	get:
		return -q -r
var vertices: Array
var sides: Array

func _init(q_: int, r_: int, size: float):
	q = q_
	r = r_

	position.x += sqrt(3) * size * q + 0.5 * sqrt(3) * size * r
	position.y += (3.0/2.0) * size * r
	
	vertices.resize(6)
	sides.resize(6)
	
	for i in range(6):
		vertices[i] = null
		sides[i] = null

func pointy_hex_corner(size, i):
	var angle_rad = PI/3 * i + PI/6
	return Vector2(position.x + size * cos(angle_rad), position.y - size * sin(angle_rad))
