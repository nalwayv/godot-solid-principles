class_name HealthTrigger
extends PowerUp

@export var heal_value: float = 5

func _apply_effect(body: Node3D) -> void:
	if body.has_meta("Health"):
		(body.get_meta("Health") as Health).heal(heal_value)
