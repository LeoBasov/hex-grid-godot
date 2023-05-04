class_name HexCell extends Node2D

var r: int
var q: int

func _init(r_: int, q_: int, size: float):
	r = r_
	q = q_

	position.x += sqrt(3) * size * r + 0.5 * sqrt(3) * size * q
	position.y += (3.0/2.0) * size * q
