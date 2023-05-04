extends Camera2D

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			#fov += 1 #Camera
			zoom += Vector2(1, 1)*0.1 #Camera2D
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			#fov -= 1 #Camera
			zoom -= Vector2(1, 1)*0.1 #Camera2D
