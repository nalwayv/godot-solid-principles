class_name DamagedTarget
extends Node3D


## Send each chunk of the damaged target in random directions
func explode(explosion_force: float) -> void:
	explosion_force = absf(explosion_force)
	
	for child: RigidBody3D in get_children():
		var direction: Vector3 = position.direction_to(child.position)
		var force: Vector3 = direction * explosion_force + Utils.random_inside_unit_sphere() * (explosion_force * 0.5)
		child.apply_central_force(force)
		child.apply_torque(Utils.random_inside_unit_sphere() * explosion_force)


### Get a random point within a unit sphere
#func _random_inside_unit_sphere() -> Vector3:
	#var theta: float = randf() * 2 * PI
	#var phi: float = randf() * PI
	#
	#var sin_theta: float = sin(theta)
	#var cos_theta: float = cos(theta)
	#var sin_phi: float = sin(phi)
	#var cos_phi: float = cos(phi)
	#
	#return Vector3(sin_phi * cos_theta, sin_phi * sin_theta, cos_phi)
