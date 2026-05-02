extends CharacterBody2D

@export var player_index = 0
var bet_active : ColorRect = null
@export var movement_speed : float = 500
var character_direction : Vector2
var list_bet = [3, 4, 5, 7]
var _n = 0;
var coincreation = preload("res://Scenes/coin_creation.tscn")

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

		
func _input(_event: InputEvent) -> void:
	if bet_active != null :
		if Input.is_joy_button_pressed(player_index, JOY_BUTTON_A) && !list_bet.is_empty() :
			if bet_active.activebet :
				var instance = coincreation.instantiate()
				var _s = list_bet.pop_at(_n)
				bet_active.bettingValue = _s
				instance.position = Vector2(0,0)
				instance.get_child(0).playerid = player_index 
				instance.get_child(1).text = str(_s)
				bet_active.add_child(instance)
				
				bet_active.bet_actions(_s)
				if(_n > 0) :
					_n = _n-1
				$Ressources.hide()	
				$UI_Player.hide()

		if Input.is_joy_button_pressed(player_index, JOY_BUTTON_RIGHT_SHOULDER) && _n < list_bet.size()-1 :
			_n = _n+1
		if Input.is_joy_button_pressed(player_index, JOY_BUTTON_LEFT_SHOULDER) && _n > 0 :
			_n = _n-1
		if !list_bet.is_empty() :
			$Ressources.text = str(list_bet[_n])
			if bet_active.activebet :
				$Ressources.show()
				$UI_Player.show()
	else :
		$Ressources.hide()	
		$UI_Player.hide()
