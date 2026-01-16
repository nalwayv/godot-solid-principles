class_name CameraRayPicker
extends Camera3D

const RAY_LENGTH: int = 100

@export var method_name: String

@onready var ray: RayCast3D = $RayCast3D


func _process(_delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray.target_position = project_local_ray_normal(mouse_position) * RAY_LENGTH
	ray.force_raycast_update()

	if ray.is_colliding():
		var collider := ray.get_collider() as Switch
		if collider and Input.is_action_just_pressed("click"):
			collider.toggle()
