extends Button
var NumberOfRound = 0
signal nextRound()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed() -> void:
	if NumberOfRound<3:
		NumberOfRound +=1
		nextRound.emit()
		hide()
	else:
		print("GameEnd")
