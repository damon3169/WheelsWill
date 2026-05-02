extends Area2D
var NumberOfRound = 0
signal nextRound()
var result = load("res://Scenes/result.tscn")
var canRelaunch = false
var players
var playerIn:Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	players = get_tree().get_nodes_in_group("Players")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onAllPlayerReset() -> void:
	if NumberOfRound<3:
		NumberOfRound +=1
		nextRound.emit()
		hide()
	else:
		var instance = result.instantiate()
		var resultPlayers: Array
		get_parent().get_parent().get_parent().add_child(instance)
		get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
		for i in range(len(players)):
			resultPlayers.append([players[i].player_index,players[i].score])
		resultPlayers.sort_custom(func(a, b): return a[1] > b[1])
		

func sort_ascending(a, b):
	if a[1] < b[1]:
		return true
	return false



func _on_body_entered(body: Node2D) -> void:
	playerIn.append(body)
	canRelaunch = true
	for i in range(len(players)):
		if playerIn.find(players[i]) ==-1:
			canRelaunch = false
			break
	if canRelaunch:
		onAllPlayerReset() 
	pass # Replace with function body.


func _on_body_exited(body: Node2D) -> void:
	playerIn.erase(body)
	pass # Replace with function body.
