extends ColorRect

func _on_area_2d_body_entered(body: Node2D) -> void:
	color = Color.BROWN
	body.bet_active = self
	print(body.bet_active)


func _on_area_2d_body_exited(body: Node2D) -> void:
	color = Color.REBECCA_PURPLE
	body.bet_active = null
	print(body.bet_active)
