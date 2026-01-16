class_name Projectile
extends RigidBody3D

@export var lifetime: float = 2
@export var damage: float = 1

var muzzel_velocity: float
var pool: ObjectPool

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(deactivate)
	body_entered.connect(_on_body_entered)


## Stops the projectile's movement and returns it to the pool if available.
func deactivate() -> void:
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	if pool:
		pool.release_object(self)


## Launches the projectile from a specified transform.
func launch(start_transform: Transform3D):
	global_transform = start_transform
	apply_central_impulse(-basis.z * muzzel_velocity)
	timer.start(lifetime)


func _on_body_entered(_body: Node) -> void:
	deactivate()
