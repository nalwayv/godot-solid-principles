extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		var parent := owner as AreaEffect
		parent.play_effect()
		parent.show_area_text()


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		var parent := owner as AreaEffect
		parent.stop_effect()
		parent.show_text("")
