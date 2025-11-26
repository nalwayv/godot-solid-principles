@abstract 
class_name Switchable
extends Node

var is_active: bool


func _enter_tree() -> void:
	owner.set_meta("Switchable", self)


@abstract 
func activate() -> void


@abstract 
func deactivate() -> void
