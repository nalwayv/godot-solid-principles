class_name Explode
extends Node3D

const DamageTargetScene: PackedScene = preload("uid://di3r326dnsnde")

@export var explosion_force: float = 100


func _enter_tree() -> void:
	owner.set_meta("Explode", self)


## Instantiate a new exploded target scene that will immediately explode into chunks
func explode() -> void:
	var parent := get_parent_node_3d()
	if not parent:
		return
		
	var target := DamageTargetScene.instantiate() as DamagedTarget
	get_tree().root.add_child(target)
	target.transform = parent.transform
	target.explode(explosion_force)
	
