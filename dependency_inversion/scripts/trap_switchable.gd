extends Switchable

@export var rigidbody: RigidBody3D

var original_transform: Transform3D


func _ready() -> void:
	rigidbody.axis_lock_angular_x = true
	original_transform = owner.transform


func activate() -> void:
	is_active = true
	rigidbody.axis_lock_angular_x = false


func deactivate() -> void:
	is_active = false
	rigidbody.axis_lock_angular_x = true
	rigidbody.transform = original_transform
