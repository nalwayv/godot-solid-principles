class_name SpeedModifier
extends Node3D

var _active: bool
var _duration: float

@onready var timer: Timer = $Timer
@onready var particles: GPUParticles3D = $Particles


func _enter_tree() -> void:
	owner.set_meta("SpeedModifier", self)


func _exit_tree() -> void:
	owner.remove_meta("SpeedModifier")


func modify_speed(multiplier: float, duration: float):
	if _active:
		# force stop timer
		timer.stop()
		timer.timeout.emit()
		
		_apply_speed_modifier(multiplier, _duration + duration - Time.get_ticks_msec())
	else:
		_duration = Time.get_ticks_msec() + duration
		_apply_speed_modifier(multiplier, duration)
		
	particles.restart()


func _apply_speed_modifier(multiplier: float, duration: float):
	# apply speed effect
	if not _active:
		_active = true
		if owner.has_meta("Movable"):
			(owner.get_meta("Movable") as Movable).speed_multiplyer *= multiplier
		timer.start(duration)
	
	await timer.timeout
	
	# remove speed effect
	if Time.get_ticks_msec() >= _duration:
		_active = false
		if owner.has_meta("Movable"):
			(owner.get_meta("Movable") as Movable).speed_multiplyer /= multiplier
