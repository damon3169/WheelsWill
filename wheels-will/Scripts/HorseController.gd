extends Area2D
@export var id =0
@export var speed =16
@export var acceleration = 50
var gameIsWon = false
var nextRoomButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nextRoomButton = get_tree().get_nodes_in_group("nextRoomButton")
	nextRoomButton[0].nextRound.connect(emit_nextRound)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !gameIsWon:
		position.x+=speed*delta

func horseAcceleration() ->void:
	speed+=acceleration
	await get_tree().create_timer(1).timeout
	speed-=acceleration
	pass

func emit_nextRound() ->void:
	gameIsWon = false
	var horseGroup = get_tree().get_nodes_in_group("HorseGroup")
	for i in range(len(horseGroup)):
		horseGroup[i].position.x = 0
	pass
