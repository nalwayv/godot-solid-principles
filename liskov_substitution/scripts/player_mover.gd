class_name Movable
extends Node3D

@export var move_speed: float = 5.0
@export var acceleration: float = 10.0
@export var deceleration: float = 5.0
@export var speed_multiplyer: float = 1.0

var _parent: CharacterBody3D
var _current_speed: float


func _enter_tree() -> void:
	owner.set_meta("Movable", self)


func _exit_tree() -> void:
	owner.remove_meta("Movable")


func _ready() -> void:
	_parent = get_parent() as CharacterBody3D


## update the x and z property of a character body3d
func move(input_direction: Vector2, delta: float) -> void:
	if _parent == null:
		return
		
	# movement
	if input_direction == Vector2.ZERO:
		if _current_speed > 0:
			_current_speed = max(_current_speed - deceleration * delta, 0)
	else:
		_current_speed = lerpf(_current_speed, move_speed, acceleration * delta)
	
	var dir_xz := Vector3(input_direction.x, 0, input_direction.y)
	var direction: Vector3 = (transform.basis * dir_xz).normalized()

	_parent.velocity.x = direction.x * _current_speed * speed_multiplyer
	_parent.velocity.z = direction.z * _current_speed * speed_multiplyer
