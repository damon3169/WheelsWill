extends Node2D
@export var horseGroup :Array
@export var horseGroupSorted:Array
var betGroup: Array
var nextRoomButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nextRoomButton = get_tree().get_nodes_in_group("nextRoomButton")
	nextRoomButton[0].nextRound.connect(emit_nextRound)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_finish_line_horse_won(horseHasWon: bool, horseID: int) -> void:
	horseGroup = get_tree().get_nodes_in_group("HorseGroup")
	horseGroupSorted.clear()
	for i in range(len(horseGroup)):
		horseGroup[i].get_child(1).play("Idle")
		horseGroupSorted.append([horseGroup[i].id,horseGroup[i].position.x])
	horseGroupSorted.sort_custom(func(a, b): return a[1] > b[1])
	var HorseGroupSortedFinish : Array
	for  i in range(len(horseGroupSorted)):
		HorseGroupSortedFinish.append(horseGroupSorted[i][0])
	print(HorseGroupSortedFinish)
	for  i in range(len(HorseGroupSortedFinish)):
			for j in range(len(horseGroup)):
				if HorseGroupSortedFinish[i] == horseGroup[j].id:
					horseGroup[j].get_child(2).text =str("top "+str(i+1))
	betGroup = get_tree().get_nodes_in_group("BetGroup")
	for i in range(len(betGroup)):
		betGroup[i].validate_bet(HorseGroupSortedFinish)
	nextRoomButton[0].visible = true
	HorseGroupSortedFinish.clear()
	pass


func sort_ascending(a, b):
	if a[1] < b[1]:
		return true
	return false

func emit_nextRound() ->void:
	pass
