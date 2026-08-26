extends Node2D


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		body.velocity.y=-300
		if body.has_node("FX"):
			body.get_node("FX").play()
		queue_free()
	
