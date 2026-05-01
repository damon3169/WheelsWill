extends Node2D

@export var outer_raduis: int = 128
@export var inner_radius: int = 64
@export var bkg_color: Color
@export var line_color: Color
@export var line_width: int = 4
@export var horseWeigh = Array([], TYPE_FLOAT, "", null) 
@export var horsePercentageGain = Array([], TYPE_FLOAT, "", null) 
@export var horsePercentage = Array([], TYPE_FLOAT, "", null) 
@export var horseAngle = Array([], TYPE_FLOAT, "", null) 
@export var horseColor = Array([], TYPE_COLOR, "", null) 
@export var horseCollisions :Array
var x : float
var time:float = 0
@export var rotationSpeed:float=5
@export var lastWinner:int =0
@export var timer =2.0
@export var lastWinnerselected = false
@export var countRound = 0.0
@export var nbRound = 0.0
var choosingWinner:bool = true
@export var pauseWinner = 1.0
@export var pauseChoosingWinner = 2.0
@export var horseGroup :Array
var isGameWon = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	horseGroup= get_tree().get_nodes_in_group("HorseGroup")
	var total =0
	var lastAngle = 0.0
	for i in range(len(horseWeigh)):
		total +=horseWeigh[i]
	for i in range(len(horseWeigh)):
		horsePercentage.append(horseWeigh[i]/(total/100.0))
	for i in range(len(horseWeigh)):
		horseAngle.append(lastAngle+((360.0/100.0)* horsePercentage[i]))
		lastAngle = horseAngle[i]
	horseCollisions= get_tree().get_nodes_in_group("WheelColision")

func AddValueHorseWeigh(horseNum:float,value:float) ->void:
	horseWeigh[horseNum]= horseWeigh[horseNum]+ (horseWeigh[horseNum]/100)*value
	var total =0.0
	var lastAngle = 0.0
	for i in range(len(horseWeigh)):
		total +=horseWeigh[i]
	for i in range(len(horseWeigh)):
		horsePercentage[i]=(horseWeigh[i]/(total/100.0))
	for i in range(len(horseWeigh)):
		horseAngle[i] =(lastAngle+((360.0/100.0)* horsePercentage[i]))
		lastAngle = horseAngle[i]
		queue_redraw()

func _physics_process(delta: float) -> void:
	if !isGameWon:
		if time<timer && choosingWinner:
			rotation_degrees-=rotationSpeed
			countRound +=rotationSpeed
			if countRound >= 360.0:
				countRound =0
				nbRound+=1
			time+=delta
		elif time<timer && !choosingWinner:
			time+=delta
			pass
		else :
			if choosingWinner:
				#faire avancer le cheval
				choosingWinner = false
				timer =pauseWinner
				time = 0
				print(lastWinner)
				horseGroup[lastWinner].horseAcceleration()
				AddValueHorseWeigh(lastWinner,horsePercentageGain[lastWinner])
				print("test")
			else:
				choosingWinner=true
				pauseChoosingWinner=randf_range(1,3)
				rotationSpeed=randf_range(1,5)
				timer =pauseChoosingWinner
				time = 0
			

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("addTest"):
		AddValueHorseWeigh(4,-25)
		print("t")
func _draw() -> void:
	draw_circle(Vector2.ZERO,outer_raduis, bkg_color)
	draw_arc(Vector2.ZERO,inner_radius,0,TAU,128, line_color, line_width,true)
	if len(horseWeigh) >=3:
		var point = Vector2.from_angle(0)
		draw_line(
			point*inner_radius,
			point*outer_raduis,
			line_color,
			line_width,
			true
		)
		for i in range(len(horseWeigh)-1):
			
			point = Vector2.from_angle(deg_to_rad(horseAngle[i]))
			draw_line(
				point*inner_radius,
				point*outer_raduis,
				line_color,
				line_width,
				true
			)
		var angleDegreeStart=0
		var angleDegreeEnd=0
		for i in range(len(horseWeigh)):
			if i==0:
				angleDegreeStart =0
			else:
				angleDegreeStart = deg_to_rad(-horseAngle[i-1])
			var start_rads = angleDegreeStart
			angleDegreeEnd =deg_to_rad(-horseAngle[i])
			var ends_rads =angleDegreeEnd
			var points_per_arc =32
			var points_inner = PackedVector2Array()
			var points_outer = PackedVector2Array()
			for j in range(points_per_arc+1):
				var angle = start_rads + j * (ends_rads-start_rads)/points_per_arc
				points_inner.append(inner_radius*Vector2.from_angle(TAU-angle))
				points_outer.append(outer_raduis*Vector2.from_angle(TAU-angle))
			horseCollisions[i].position = points_outer[0]
			points_outer.reverse()
			draw_polygon(
				points_inner+points_outer,
				PackedColorArray([horseColor[i]])
			)


func _on_horse_horse_won(won: bool, horseWonID: int) -> void:
	isGameWon=won
	pass # Replace with function body.


func _on_horse_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
