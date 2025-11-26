class_name HexagonEffect
extends AreaEffect

@export var side_length: int = 1


func _calculate_area() -> float:
	return (3 * sqrt(3) / 2) * side_length * side_length
