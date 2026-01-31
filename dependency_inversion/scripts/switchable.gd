@abstract 
class_name Switchable
extends Node

var is_active: bool


func _enter_tree() -> void:
	owner.add_to_group("switchable")


@abstract 
func activate() -> void


@abstract 
func deactivate() -> void
