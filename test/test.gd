extends Node2D

func _ready():
	$HexGrid.position = get_viewport().get_visible_rect().size * 0.5
	$HexGrid.build(1)
