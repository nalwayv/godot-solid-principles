## NOTE: messing with tweens
extends Node3D

var is_open: bool = false
var original_rotation: Vector3
var open_rotation := Vector3(90.0, 0.0, 0.0)
var speed: float = 0.99

@onready var hinge: Node3D = $Hinge

func _ready() -> void:
	original_rotation = hinge.rotation_degrees
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("click") and not is_open:
		is_open = true
		var tween: Tween = create_tween()
		tween.tween_property(hinge, "rotation_degrees", open_rotation, speed)\
			.set_trans(Tween.TRANS_BACK)\
			.set_ease(Tween.EASE_OUT)
	elif Input.is_action_just_pressed("Click") and is_open:
		is_open = false
		var tween: Tween = create_tween()
		tween.tween_property(hinge, "rotation_degrees", original_rotation, speed)\
			.set_trans(Tween.TRANS_BACK)\
			.set_ease(Tween.EASE_OUT)
