extends Area2D
@export var id =0
@export var speed =16
@export var acceleration = 50
signal horseWon(won:bool,horseWonID:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x+=speed*delta
	pass

func horseAcceleration() ->void:
	speed+=acceleration
	await get_tree().create_timer(1).timeout
	speed-=acceleration
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.name=="finishLine":
		horseWon.emit(true, id)
	pass # Replace with function body.
