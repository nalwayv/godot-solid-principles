class_name SpeedTrigger
extends PowerUp

@export var duration: float = 2
@export var multiplier: float = 2

func _apply_effect(body: Node3D) -> void:
	if body.has_meta("SpeedModifier"):
		(body.get_meta("SpeedModifier") as SpeedModifier).modify_speed(multiplier, duration)
