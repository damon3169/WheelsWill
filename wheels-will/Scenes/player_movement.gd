extends CharacterBody2D

@export var player_index = 0;
@export var movement_speed : float = 500
var character_direction : Vector2

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
