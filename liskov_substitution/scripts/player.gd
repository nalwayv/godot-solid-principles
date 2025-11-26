class_name LiscovPlayer
extends CharacterBody3D

func _physics_process(delta: float) -> void:
	var input_direction: Vector2 = Input.get_vector("left", "right", "forward", "back")

	if has_meta("Movable"):
		(get_meta("Movable") as Movable).move(input_direction, delta)
	
	move_and_slide()
