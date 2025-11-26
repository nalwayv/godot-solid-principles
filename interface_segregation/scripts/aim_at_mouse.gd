class_name AimAtMouse
extends Node3D

@export var pan_speed: float = 5
@export var tilt_speed: float = 50
@export var max_tilt_up: float = 35
@export var max_tilt_down: float = -5
@export var offset: Vector3

var _mouse_to_world: MouseToWorldPosition

@onready var pan: Node3D = %Pan
@onready var tilt: Node3D = %Tilt


func _ready() -> void:
	max_tilt_down = -absf(max_tilt_down)
	max_tilt_up = absf(max_tilt_up)
	_mouse_to_world = get_tree().get_first_node_in_group("to_world") as MouseToWorldPosition


func _process(delta: float) -> void:
	if _mouse_to_world == null:
		return
		
	_rotate_pan_towards(_mouse_to_world.hit_position, delta)
	_rotate_tilt_towards(_mouse_to_world.hit_position, delta)


## Rotates the pan node horizontally to face the target position.
##
## Smoothly interpolates the pan node's rotation on the Y-axis to aim
## towards the specified target position.
func _rotate_pan_towards(target: Vector3, delta: float) -> void:
	var direction_to_target: Vector3 = offset + target - pan.global_position
	direction_to_target.y = 0
	
	# prevent undefined behavior
	if direction_to_target == Vector3.ZERO:
		return
	
	# rotate to target
	var target_rotation := Basis.looking_at(direction_to_target)
	pan.basis = pan.basis.slerp(target_rotation, pan_speed * delta)
	
	# using Quaternion
	#var pan_quat := Quaternion(pan.basis)
	#var target_quat := Quaternion(target_rotation)
	#var slerp_quat: Quaternion = pan_quat.slerp(target_quat, pan_speed * delta)
	#pan.basis = Basis(slerp_quat)


## Rotates the tilt node vertically to aim at the target position.
##
## Smoothly interpolates the tilt node's rotation on the X-axis to aim
## towards the specified target.
func _rotate_tilt_towards(target: Vector3, delta: float) -> void:
	var direction_to_target: Vector3 = offset + target - tilt.global_position
	# Unity - InverseTransformDirection: convert from global to local
	var direction_to_local: Vector3 = pan.global_transform.basis.inverse() * direction_to_target
	
	# calculate tilt angle by converting a direction vector into  angle
	var tilt_angle_rad: float = atan2(direction_to_local.y, -direction_to_local.z)
	var tilt_angle_deg: float = rad_to_deg(tilt_angle_rad)
	tilt_angle_deg = clampf(tilt_angle_deg, max_tilt_down, max_tilt_up)
	tilt_angle_rad = deg_to_rad(tilt_angle_deg)
	
	var target_rotation := Basis.from_euler(Vector3(tilt_angle_rad, 0, 0))
	tilt.basis = tilt.basis.slerp(target_rotation, tilt_speed * delta)
	tilt.orthonormalize()

	# Quaternion
	#var basis_quat := Quaternion(tilt.basis)
	#var target_quat := Quaternion.from_euler(Vector3(tilt_angle_rad, 0, 0))
	#var slerp_quat: Quaternion = basis_quat.slerp(target_quat, tilt_speed * delta)
	#tilt.basis = Basis(slerp_quat)
