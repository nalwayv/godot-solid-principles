class_name DamageBox
extends Node3D

@export var amplitude: float = 0.5
@export var frequency: float = 2

var _time: float

func _process(delta: float) -> void:
	_time += delta
	## bounce up and down
	var new_y: float = amplitude * absf(sin(_time * frequency))
	position.y = new_y
