extends Node2D

var result
var labels
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	result = get_parent().get_child(0)
	labels =  get_tree().get_nodes_in_group("labelResult")
	print(result.arrayScrorePlayer)
	for i in range(len(result.arrayScrorePlayer)):
			labels[i].text= "Player "+str(result.arrayScrorePlayer[i][0])+ "has "+ str(result.arrayScrorePlayer[i][1])+"points."
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
