class_name MouseToWorldPosition
extends Node3D

const RAY_LENGTH: int = 1000

@export var camera: Camera3D
@onready var ray: RayCast3D = $RayCast3D

var hit_position: Vector3


func _get_mouse_world_space_position() -> Vector3:
	if not camera:
		return Vector3.ZERO
	
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var from: Vector3 = camera.project_ray_origin(mouse_position)
	var to: Vector3 = from + camera.project_ray_normal(mouse_position) * RAY_LENGTH
	
	ray.position = camera.position
	ray.target_position = to
	ray.force_raycast_update()
	
	if ray.is_colliding():
		return ray.get_collision_point()
	return to


func _process(_delta: float) -> void:
	hit_position = _get_mouse_world_space_position()
	$CollisionPoint.position = hit_position
