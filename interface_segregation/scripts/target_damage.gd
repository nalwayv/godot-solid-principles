class_name TargetDamage
extends TargetHealth


@export var damage_multiplyer: float = 2


func _take_damage(amount: float) -> void:
	super._take_damage(amount * damage_multiplyer)


func _destroyed() -> void:
	if owner.has_meta("Explode"):
		(owner.get_meta("Explode") as Explode).explode()
	super._destroyed()
