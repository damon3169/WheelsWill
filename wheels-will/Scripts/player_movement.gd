extends CharacterBody2D

@export var player_index = 0
var listcontroller : Array
var bet_activeArray : Array
@export var movement_speed : float = 500
var character_direction : Vector2
var score = 0
var list_bet = [3, 4, 5, 6]
var _n = 0;
var coincreation = preload("res://Scenes/coin_creation.tscn")
var chara_0 = preload("res://Sprites/Chara/Chara_J0.tres")
var chara_1 = preload("res://Sprites/Chara/Chara_J1.tres")
var chara_2 = preload("res://Sprites/Chara/Chara_J2.tres")
var chara_3 = preload("res://Sprites/Chara/Chara_J3.tres")
var coin_0 = preload("res://Sprites/Enviro/CoinJ0.png")
var coin_1 = preload("res://Sprites/Enviro/CoinJ1.png")
var coin_2 = preload("res://Sprites/Enviro/CoinJ2.png")
var coin_3 = preload("res://Sprites/Enviro/CoinJ3.png")
var resetround

func _ready() -> void:
	listcontroller = Input.get_connected_joypads()
	if  player_index+1 > listcontroller.size() :
		queue_free()
	resetround = get_tree().get_nodes_in_group("nextRoomButton")
	resetround[0].nextRound.connect(emit_nextRound)
	match player_index :
		0:
			$sprite.sprite_frames = chara_0
			$CoinSprite.texture = coin_0
		1:
			$sprite.sprite_frames = chara_1
			$CoinSprite.texture = coin_1
		2:
			$sprite.sprite_frames = chara_2
			$CoinSprite.texture = coin_2
		3:
			$sprite.sprite_frames = chara_3
			$CoinSprite.texture = coin_3
	pass # Replace with function body.

func _physics_process(delta: float):
	character_direction.x = Input.get_joy_axis(player_index, JOY_AXIS_LEFT_X)
	if character_direction.x < 0.2 && character_direction.x > -0.2:
		character_direction.x = 0
	character_direction.y = Input.get_joy_axis(player_index, JOY_AXIS_LEFT_Y)
	if character_direction.y < 0.2 && character_direction.y > -0.2:
		character_direction.y = 0
	character_direction = character_direction.normalized()
	
	#flip
	if character_direction.x > 0: %sprite.flip_h = false
	elif character_direction.x < 0: %sprite.flip_h = true
	
	if character_direction:
		velocity = character_direction * movement_speed
		if %sprite.animation != "Walking": %sprite.animation = "Walking"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		if %sprite.animation != "Idle": %sprite.animation = "Idle"
		
	move_and_slide()
	$Score.text = str(score)

		
func _input(_event: InputEvent) -> void:
	if len(bet_activeArray) != 0  && !bet_activeArray[0].betclosed :
		if Input.is_joy_button_pressed(player_index, JOY_BUTTON_A) && !list_bet.is_empty() :
			if bet_activeArray[0].activebet :
				var instance = coincreation.instantiate()
				var _s = list_bet.pop_at(_n)
				bet_activeArray[0].bettingValue = _s
				instance.position = Vector2(0,0)
				instance.get_child(0).playerid = player_index 
				instance.get_child(1).text = str(_s)
				instance.z_index = 15
				bet_activeArray[0].add_child(instance)
				
				bet_activeArray[0].bet_actions(_s,self)
				if(_n > 0) :
					_n = _n-1
				$Ressources.hide()	
				$CoinSprite.hide()

		if Input.is_joy_button_pressed(player_index, JOY_BUTTON_RIGHT_SHOULDER) && _n < list_bet.size()-1 :
			_n = _n+1
		if Input.is_joy_button_pressed(player_index, JOY_BUTTON_LEFT_SHOULDER) && _n > 0 :
			_n = _n-1
		if !list_bet.is_empty() :
			$Ressources.text = str(list_bet[_n])
			if bet_activeArray[0].activebet :
				$Ressources.show()
				$CoinSprite.show()
	else :
		$Ressources.hide()	
		$CoinSprite.hide()
		
func emit_nextRound() ->void:
	list_bet = [3, 4, 5, 6]
	_n = 0;
	get_tree().call_group("coins", "queue_free")
pass
