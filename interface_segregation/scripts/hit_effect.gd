class_name HitEffect
extends Node3D

@onready var particles: GPUParticles3D = $Particles


func _enter_tree() -> void:
	owner.set_meta("HitEffect", self)


## Render hit particle effect
func trigger_effect(origin: Vector3, normal: Vector3) -> void:
	## align basis y with normal
	var new_basis := particles.global_basis
	new_basis.y = normal
	new_basis.x = -new_basis.z.cross(normal)
	new_basis = new_basis.orthonormalized()
	
	particles.global_basis = new_basis
	particles.global_position = origin
	particles.restart()
