class_name CircleEffect
extends AreaEffect

@export var radius: float = 1

func _calculate_area() -> float:
	return PI * radius * radius 
