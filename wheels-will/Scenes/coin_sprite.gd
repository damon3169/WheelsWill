extends Sprite2D

var playerid = 0;
var coin0 = preload("res://Sprites/Enviro/CoinJ0.png")
var coin1 = preload("res://Sprites/Enviro/CoinJ1.png")
var coin2 = preload("res://Sprites/Enviro/CoinJ2.png")
var coin3 = preload("res://Sprites/Enviro/CoinJ3.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match playerid:
		0: 
			texture = coin0
		1:
			texture = coin1
		2:
			texture = coin2
		3:
			texture = coin3
	pass # Replace with function body.
