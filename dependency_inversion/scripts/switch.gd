class_name Switch
extends StaticBody3D

@export var switchable: Node3D


func toggle() -> void:
	if switchable == null:
		return
		
	if switchable.has_meta("Switchable"):
		var switch := (switchable.get_meta("Switchable") as Switchable)
		
		if switch.is_active:
			switch.deactivate()
		else:
			switch.activate()
