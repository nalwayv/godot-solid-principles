class_name HealthBar
extends Node3D

@export var duration: float = 1

@onready var timer: Timer = $Timer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var label: Label = %Label


func _enter_tree() -> void:
	owner.set_meta("HealthBar", self)


func _ready() -> void:
	if owner.has_meta("Health"):
		var health = (owner.get_meta("Health") as Health)
		health.health_changed.connect(_update_health_bar)
		_update_health_bar(health.start_health / health.max_health)


func _update_health_bar(health_value: float) -> void:
	if not timer.is_stopped():
		timer.stop()
	
	_lerp_health_bar(health_value)
	progress_bar.value = health_value
	label.text = str(health_value * 100)


func _lerp_health_bar(target: float) -> void:
	var start_value: float = progress_bar.value
	timer.start(duration)
	
	while timer.time_left > 0:
		progress_bar.value = lerpf(start_value, target, 1.0 - timer.time_left / duration)
		await get_tree().process_frame
		
	progress_bar.value = target
