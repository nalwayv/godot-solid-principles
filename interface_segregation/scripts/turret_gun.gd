class_name TurretGun
extends Node3D

const ProjectileScene: PackedScene = preload("uid://d1vhhuefby40m")

@export var muzzel_velocity: float = 20
@export var fire_rate: float = 15
@export var pool: ObjectPool

@onready var muzzel_marker: Marker3D = %MuzzelMarker
@onready var shoot_timer: Timer = $ShootTimer
@onready var ray_cast: RayCast3D = %RayCast3D


func _exit_tree() -> void:
	pool.clear()
	
	
func _ready() -> void:
	if pool != null:
		pool.on_create_object = create_projectile
		pool.on_get_object = get_from_pool
		pool.on_release_object = release_from_pool
		pool.on_destroy_object = destroy_projectile
		pool.setup_pool(10)


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("shoot") and shoot_timer.is_stopped():
		shoot()


func shoot() -> void:
	if pool == null:
		return
		
	var projectile := pool.get_object() as Projectile
	if projectile != null:
		projectile.launch(muzzel_marker.global_position, Quaternion(muzzel_marker.global_basis))
		shoot_timer.start(1.0 / fire_rate)
		
		ray_cast.force_raycast_update()
		if ray_cast.is_colliding():
			var collider := ray_cast.get_collider()
			var collision_point: Vector3 = ray_cast.get_collision_point()
			var collision_normal: Vector3 = ray_cast.get_collision_normal()
			
			_handle_damage(collider, projectile.damage)
			_handle_effect(collider, collision_point, collision_normal)
			

func _handle_damage(collider: Object, damage: float) -> void:
	if collider.has_meta("TargetHealth"):
		(collider.get_meta("TargetHealth") as TargetDamage)._take_damage(damage)


func _handle_effect(collider: Object, collision_point: Vector3, collision_normal: Vector3) -> void:
	if collider.has_meta("HitEffect"):
		(collider.get_meta("HitEffect") as HitEffect).trigger_effect(collision_point, collision_normal)


## ObjectPool Callable


func create_projectile() -> Projectile:
	var projectile := ProjectileScene.instantiate() as Projectile
	add_child(projectile)
	
	projectile.muzzel_velocity = muzzel_velocity
	projectile.pool = pool
	
	return projectile


func get_from_pool(projectile: Projectile):
	projectile.show()
	projectile.set_process(true)
	projectile.set_physics_process(true)


func release_from_pool(projectile: Projectile):
	projectile.hide()
	projectile.set_process(false)
	projectile.set_physics_process(false)


func destroy_projectile(projectile: Projectile) -> void:
	projectile.queue_free()
