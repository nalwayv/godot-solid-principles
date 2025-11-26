## NOTE - in the unity project each projectile would check for a collision with the target
## but for fast moving projectiles this sometimes measn they just fly though the collision box 
## and are not registered as a hit, so the gun class uses a raycast to handle hit 
class_name Projectile
extends RigidBody3D

@export var lifetime: float = 2
@export var damage: float = 1

var muzzel_velocity: float
var pool: ObjectPool


func _ready() -> void:
	$Timer.timeout.connect(deactivate)
	body_entered.connect(_on_body_entered)


## Stops the projectile's movement and returns it to the pool if available.
func deactivate() -> void:
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	if pool:
		pool.release_object(self)


## Launches the projectile from a specified position and orientation.
func launch(start_global_position: Vector3, start_angle: Quaternion):
	global_position = start_global_position
	transform.basis = Basis(start_angle)
	
	apply_central_impulse(-basis.z * muzzel_velocity)
	
	$Timer.start(lifetime)


func _on_body_entered(_body: Node) -> void:
	deactivate()
