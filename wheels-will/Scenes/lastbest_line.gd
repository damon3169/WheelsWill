extends Sprite2D


var buttonPressed = preload("res://Sprites/Enviro/BettingCasePushed.png")
var betgroup
func _on_area_2d_area_entered(body: Node2D) -> void:
	betgroup= get_tree().get_nodes_in_group("BetGroup")
	for i in range(len(betgroup)) :
		betgroup[i].betclosed = true
		betgroup[i].get_child(0).texture = buttonPressed

	
