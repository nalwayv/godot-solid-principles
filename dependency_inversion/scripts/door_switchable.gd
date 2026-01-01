extends Switchable

@export var door_left: Node3D
@export var door_right: Node3D

@export var door_left_offset: Vector3
@export var door_right_offset: Vector3
@export_range(0.0, 1.0) var speed: float

var door_left_start_position: Vector3
var door_right_start_position: Vector3
var door_left_end_position: Vector3
var door_right_end_position: Vector3


func _ready() -> void:
	door_left_start_position = door_left.position
	door_right_start_position = door_right.position
	door_left_end_position = door_left.position + door_left_offset
	door_right_end_position = door_right.position + door_right_offset


func activate() -> void:
	is_active = true
	
	var open_speed: float = 1.0 - (speed / 1.0)
		
	var tween_open_door: Tween = create_tween()
	tween_open_door.tween_property(door_left, "position", door_left_end_position, open_speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	tween_open_door.set_parallel()
	tween_open_door.tween_property(door_right, "position", door_right_end_position, open_speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	
	
func deactivate() -> void:
	is_active = false
	
	var close_speed: float = 1.0 - (speed / 1.0)
	
	var tween_close_door: Tween = create_tween()
	tween_close_door.tween_property(door_left, "position", door_left_start_position, close_speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN)
	tween_close_door.set_parallel()
	tween_close_door.tween_property(door_right, "position", door_right_start_position, close_speed)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN)
