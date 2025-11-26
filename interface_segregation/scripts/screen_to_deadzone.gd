##NOTE: not in use atm
class_name ScreenDeadZone
extends Node

@export_range(0, 1, 0.1) var percentage_x: float = 0
@export_range(0, 1, 0.1) var percentage_y: float = 0
@export_range(0, 1, 0.1) var percentage_width: float = 0.5
@export_range(0, 1, 0.1) var percentage_height: float = 1


func calculate_dead_zone() -> Rect2:
	var screen: Vector2i = DisplayServer.window_get_size()
	return Rect2(
		percentage_x * screen.x,
		percentage_y * screen.y,
		percentage_width * screen.x,
		percentage_height * screen.y,
	)


func is_mouse_in_deadzone() -> bool:
	var screen: Vector2i = DisplayServer.window_get_size()
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var actual_dead_zone: Rect2 = calculate_dead_zone()
	
	mouse_position.y = screen.y - mouse_position.y
	return actual_dead_zone.has_point(mouse_position)
