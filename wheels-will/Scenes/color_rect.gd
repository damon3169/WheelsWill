extends ColorRect

func _on_area_2d_body_entered(body: Node2D) -> void:
	color = Color.BROWN


func _on_area_2d_body_exited(body: Node2D) -> void:
	color = Color.REBECCA_PURPLE
	print(body)
