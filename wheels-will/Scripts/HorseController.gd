extends Area2D
@export var id =0
@export var speed =16
@export var acceleration = 50
var gameIsWon = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
