class_name PowerUp
extends Area3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	
	_apply_effect(body)
	_play_sound(body)


func _apply_effect(_body: Node3D) -> void:
	pass


func _play_sound(body: Node3D):
	if body.has_meta("AudioPlayer"):
		(body.get_meta("AudioPlayer") as AudioPlayer).play_track()
