class_name SamageTrigger
extends PowerUp

@export var damage_value: float = 5

func _apply_effect(body: Node3D) -> void:
	if body.has_meta("Health"):
		(body.get_meta("Health") as Health)._take_damage(damage_value)
		
