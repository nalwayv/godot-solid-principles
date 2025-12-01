class_name AudioPlayer
extends Node3D

@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer


func _enter_tree() -> void:
	owner.set_meta("AudioPlayer", self)


func play_track() -> void:
	if audio.playing:
		return
	audio.play()
