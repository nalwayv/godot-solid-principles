class_name AreaEffect
extends Node3D

@export var audio: AudioStreamPlayer3D
@export var label_text: Label3D
@export var effect: GPUParticles3D
@export var cooldown: float = 2.0

var time_between_effects: Timer = Timer.new()


func _ready() -> void:
	# effect are oneshot
	add_child(time_between_effects)
	time_between_effects.wait_time = max(1, cooldown)
	time_between_effects.one_shot = true
	time_between_effects.timeout.connect(play_effect)


func _calculate_area() -> float:
	return 0


func play_effect() -> void:
	time_between_effects.start()
	_play_particle_effect()
	_play_sound_effect()


func stop_effect() -> void:
	time_between_effects.stop()
	_stop_particle_effect()
	_stop_sound_effect()


func _stop_particle_effect() -> void:
	if not effect:
		return
	effect.emitting = false


func _play_particle_effect() -> void:
	if not effect:
		return
	effect.restart()
	#effect.emitting = true


func _play_sound_effect() -> void:
	if not audio:
		return
	audio.play()


func _stop_sound_effect() -> void:
	if not audio:
		return
	var fade_out := create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	fade_out.tween_property(audio, "volume_db", 0, 1)


func show_text(text: String) -> void:
	if not label_text:
		return
	label_text.text = text


func show_area_text() -> void:
	show_text("Area %f" % _calculate_area())
