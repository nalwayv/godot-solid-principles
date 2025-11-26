class_name TiangleEffect
extends AreaEffect

@export var side_length: int = 1


func _calculate_area() -> float:
	return (sqrt(3) / 4) * side_length * side_length
