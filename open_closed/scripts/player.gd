class_name OpenClosedPlayer
extends CharacterBody3D

@export var move_speed: float = 5.0
@export var acceleration: float = 10.0
@export var deceleration: float = 5.0
@export var speed_multiplyer: float = 1.0

var current_speed: float = 0.0

func _physics_process(delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector("left", "right", "forward", "back")
		
	if input_direction == Vector2.ZERO:
		if current_speed > 0:
			current_speed = max(current_speed - deceleration * delta, 0)
	else:
		current_speed = lerpf(current_speed, move_speed, acceleration * delta)
	
	var dir_xz := Vector3(input_direction.x, 0, input_direction.y)
	var direction: Vector3 = (transform.basis * dir_xz).normalized()
	
	velocity.x = direction.x * current_speed * speed_multiplyer
	velocity.z = direction.z * current_speed * speed_multiplyer
	
	move_and_slide()
	
