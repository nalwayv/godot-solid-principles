class_name TargetHealth
extends Node3D

signal destroyed
signal health_changed(amount: float)

@export_range(0, 100) var max_health: float = 100
@export_range(0, 100) var start_health: float = 100

var is_destoyed: bool
var current_health: float


func _enter_tree() -> void:
	owner.set_meta("TargetHealth", self)


func _ready() -> void:
	current_health = start_health


func _take_damage(amount: float) -> void:
	if is_destoyed:
		return
	
	current_health = maxf(0, current_health - amount)
	
	if current_health == 0:
		_destroyed()
	
	health_changed.emit(current_health / max_health)


func _destroyed() -> void:
	if is_destoyed:
		return
		
	is_destoyed = true
	destroyed.emit()
	
	owner.queue_free()
