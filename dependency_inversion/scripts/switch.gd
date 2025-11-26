class_name Switch
extends StaticBody3D

@export var switchable: Node3D


func toggle() -> void:
	if switchable == null:
		return
		
	if switchable.has_meta("ISwitchable"):
		var switch := (switchable.get_meta("ISwitchable") as ISwitchable)
		
		if switch.is_active:
			switch.deactivate()
		else:
			switch.activate()
