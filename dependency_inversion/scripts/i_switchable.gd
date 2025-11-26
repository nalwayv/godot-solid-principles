@abstract 
class_name ISwitchable
extends Node

var is_active: bool


func _enter_tree() -> void:
	owner.set_meta("ISwitchable", self)


@abstract 
func activate() -> void


@abstract 
func deactivate() -> void
