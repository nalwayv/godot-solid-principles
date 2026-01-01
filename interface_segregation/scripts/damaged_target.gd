class_name DamagedTarget
extends Node3D


## Send each chunk of the damaged target in random directions
func explode(explosion_force: float) -> void:
	explosion_force = absf(explosion_force)
	
	for child: RigidBody3D in get_children():
		var direction: Vector3 = position.direction_to(child.position)
		var force: Vector3 = direction * explosion_force + Utils.random_inside_unit_sphere() * (explosion_force * 0.5)
		var torque: Vector3 = Utils.random_inside_unit_sphere() * explosion_force
		
		child.apply_central_force(force)
		child.apply_torque(torque)
