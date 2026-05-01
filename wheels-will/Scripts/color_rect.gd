extends ColorRect
var activebet = true
var _lastbody : Node2D = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(activebet == true) :
		color = Color.BROWN
		_lastbody = body
	body.bet_active = self
	print(body.bet_active)
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if(activebet == true) :
		color = Color.REBECCA_PURPLE
		_lastbody = null
	body.bet_active = null
	print(body.bet_active)
	

func bet_actions(_var : int) -> void:
	color = Color.BLACK
	print(_var)
	activebet = false
