class_name HexGrid extends Node2D

@export var size: float = 100.0
var cell_map: Array[Array]
var n_circle: int

func _draw():
	for child in get_child(0).get_children():
		draw_circle(child.position, 10.0, Color.GREEN)
		
		for i in range(1, 6):
			draw_line(child.pointy_hex_corner(size, i - 1), child.pointy_hex_corner(size, i), Color.RED)
		draw_line(child.pointy_hex_corner(size, 5), child.pointy_hex_corner(size, 0), Color.RED)
			
	for child in get_child(1).get_children():
		draw_circle(child.position, 10.0, Color.BLUE)

func build(n_circle_: int) -> void:
	n_circle = n_circle_
	
	for child in get_children():
		child.queue_free()
	
	create_cells()
	create_vertices()
	
	for child in get_child(0).get_children():
		var lable = Label.new()
		lable.text = str(child.r) + ", " + str(child.q)
		child.add_child(lable)

func create_cells() -> void:
	add_child(Node2D.new())
	
	for q in range(-n_circle, n_circle + 1):
		cell_map.append([])
		
		for r in range(-n_circle, n_circle + 1):
			cell_map[q + n_circle].append(null)
	
	for q in range(-n_circle, n_circle + 1):
		for r in range(-n_circle, n_circle + 1):
			if abs(q + r) <= n_circle:
				var cell = HexCell.new(q, r, size)
				get_child(0).add_child(cell)
				cell.owner = self
				cell_map[q + n_circle][r + n_circle] = cell

func create_vertices() -> void:
	var vetex
	
	add_child(Node2D.new())
	
	for q in range(-n_circle, n_circle + 1):
		for r in range(-n_circle, n_circle + 1):
			if (abs(q + r) <= n_circle) and get_cell(q, r):
				var cell = get_cell(q, r)
				
				for i in range(6):
					var cell_n = get_neighbour(q, r, indx(i))
					var cell_np = get_neighbour(q, r, indx(i + 1))
					
					if (cell_n == null) and (cell_np == null) and (cell.vertices[i] == null):
						var vertex = HexVertex.new(cell.pointy_hex_corner(size, i))
						cell.vertices[i] = vertex
						get_child(1).add_child(vertex)
						vertex.owner = self
					elif (cell_np == null):
						if (cell.vertices[i] == null) and (cell_n.vertices[indx(i + 2)] == null):
							var vertex = HexVertex.new(cell.pointy_hex_corner(size, i))
							cell.vertices[i] = vertex
							cell_n.vertices[indx(i + 2)] = vertex
							get_child(1).add_child(vertex)
							vertex.owner = self
						else:
							var vertex = cell.vertices[i] if cell.vertices[i] else cell_n.vertices[indx(i + 2)]
							cell.vertices[i] = vertex
							cell_n.vertices[indx(i + 2)] = vertex
					elif (cell_n == null):
						if (cell.vertices[i] == null) and (cell_np.vertices[indx(i + 4)] == null):
							var vertex = HexVertex.new(cell.pointy_hex_corner(size, i))
							cell.vertices[i] = vertex
							cell_np.vertices[indx(i + 4)] = vertex
							get_child(1).add_child(vertex)
							vertex.owner = self
						else:
							var vertex = cell.vertices[i] if cell.vertices[i] else cell_np.vertices[indx(i + 4)]
							cell.vertices[i] = vertex
							cell_np.vertices[indx(i + 4)] = vertex
					else:
						if (cell.vertices[i] == null) and (cell_n.vertices[indx(i + 2)] == null) and (cell_np.vertices[indx(i + 4)] == null):
							var vertex = HexVertex.new(cell.pointy_hex_corner(size, i))
							cell.vertices[i] = vertex
							cell_n.vertices[indx(i + 2)] = vertex
							cell_np.vertices[indx(i + 4)] = vertex
							get_child(1).add_child(vertex)
							vertex.owner = self
							
	for child in get_child(0).get_children():
		for vertex in child.vertices:
			assert(vertex != null)
						
func indx(i: int) -> int:
	return i%6

func get_cell(q, r):
	if (q + n_circle <= 2 * n_circle) and (r + n_circle <= 2 * n_circle) and (q + n_circle >= 0) and (r + n_circle >= 0):
		return cell_map[q + n_circle][r + n_circle]
	else:
		return null 
		
func get_neighbour(q, r, i):
	var dq: Array = [1,  1,  0, -1, -1, 0]
	var dr: Array = [0, -1, -1, -0,  1, 1]
	
	return get_cell(q + dq[i], r + dr[i])
