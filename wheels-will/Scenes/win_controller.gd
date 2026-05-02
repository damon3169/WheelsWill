extends Node2D
@export var horseGroup :Array
@export var horseGroupSorted:Array
var betGroup: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_finish_line_horse_won(horseHasWon: bool, horseID: int) -> void:
	horseGroup = get_tree().get_nodes_in_group("HorseGroup")
	for i in range(len(horseGroup)):
		horseGroupSorted.append([horseGroup[i].id,horseGroup[i].position.x])
	horseGroupSorted.sort_custom(func(a, b): return a[1] > b[1])
	var HorseGroupSortedFinish : Array
	for  i in range(len(horseGroupSorted)):
		HorseGroupSortedFinish.append(horseGroupSorted[i][0])
	betGroup = get_tree().get_nodes_in_group("BetGroup")
	for i in range(len(betGroup)):
		betGroup[i].validate_bet(HorseGroupSortedFinish)
	pass


func sort_ascending(a, b):
	if a[1] < b[1]:
		return true
	return false
