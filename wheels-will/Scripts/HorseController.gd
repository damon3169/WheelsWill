extends Area2D
@export var id =0
@export var speed =16
@export var acceleration = 50
var gameIsWon = false
var nextRoomButton
var animationState = "Run"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nextRoomButton = get_tree().get_nodes_in_group("nextRoomButton")
	get_child(1).play("Run")
	nextRoomButton[0].nextRound.connect(emit_nextRound)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !gameIsWon:
		position.x+=speed*delta
	else:
		pass

func horseAcceleration() ->void:
	speed+=acceleration
	get_child(1).play("Boost")
	await get_tree().create_timer(1).timeout
	speed-=acceleration
	get_child(1).play("Run")
	pass

func emit_nextRound() ->void:
	gameIsWon = false
	get_child(2).text =""
	self.position.x = 0
	pass
