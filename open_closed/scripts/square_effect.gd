class_name SquareEffect
extends AreaEffect

@export var width: float = 1.0
@export var height: float = 1.0

func _calculate_area() -> float:
	return width * height
