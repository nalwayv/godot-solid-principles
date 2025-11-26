class_name Health
extends Node3D

signal died
signal health_changed(amount: float)

@export_range(0, 100) var max_health: float = 100
@export_range(0, 100) var start_health: float = 80

var is_dead: bool
var current_health: float
var is_invulnerable: bool


func _enter_tree() -> void:
	owner.set_meta("Health", self)


func _ready() -> void:
	current_health = start_health


func get_health_percent() -> float:
	return current_health / max_health


func _take_damage(amount: float) -> void:
	if is_dead or is_invulnerable:
		return
	
	current_health = maxf(0, current_health - amount)
	
	if current_health == 0:
		_die()
	
	health_changed.emit(get_health_percent())


func heal(amount: float) -> void:
	if is_dead:
		return
		
	current_health = minf(max_health, current_health + amount)
	health_changed.emit(get_health_percent())


func _die() -> void:
	if is_dead:
		return
		
	is_dead = true
	died.emit()
