class_name HexSide extends Node2D

var cells: Array = [null, null]
var vertices: Array = [null, null]

func _init(i, cell1, cell2 = null):
	cells[0] = cell1
	cells[1] = cell2
	
	vertices[0] = cell1.vertices[i]
	vertices[1] = cell1.vertices[(i + 1)%6]
	
	position = 0.5*(vertices[0].position + vertices[1].position)
	rotate((vertices[0].position + vertices[1].position).angle())
