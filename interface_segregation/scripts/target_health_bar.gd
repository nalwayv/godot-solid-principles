class_name TargetHealthBar
extends Node3D

@export var update_health_duration: float = 1

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var timer: Timer = $Timer


func _enter_tree() -> void:
	owner.set_meta("TargetHealthBar", self)


func _ready() -> void:
	if owner.has_meta("TargetHealth"):
		var health := (owner.get_meta("TargetHealth") as TargetDamage)
		health.health_changed.connect(_update_health_bar)
		_update_health_bar(health.start_health / health.max_health)


func _update_health_bar(health_value: float) -> void:
	if not timer.is_stopped():
		timer.stop()
	
	_lerp_health_bar(health_value)
	
	progress_bar.value = health_value


func _lerp_health_bar(target: float) -> void:
	var start_value: float = progress_bar.value
	timer.start(update_health_duration)
	
	while timer.time_left > 0:
		progress_bar.value = lerpf(start_value, target, 1.0 - timer.time_left / update_health_duration)
		await get_tree().process_frame
		
	progress_bar.value = target
