extends Node2D

@export var outer_raduis: int = 256
@export var inner_radius: int = 64
@export var bkg_color: Color
@export var line_color: Color
@export var line_width: int = 4
@export var horseWeigh = Array([], TYPE_FLOAT, "", null) 
@export var horsePercentage = Array([], TYPE_FLOAT, "", null) 
@export var horseAngle = Array([], TYPE_FLOAT, "", null) 
var x : float



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var total =0
	var lastAngle = 0.0
	var totalAngle = 0.0
	for i in range(len(horseWeigh)):
		total +=horseWeigh[i]
	for i in range(len(horseWeigh)):
		horsePercentage.append(horseWeigh[i]/(total/100.0))
	for i in range(len(horseWeigh)):
		horseAngle.append(lastAngle+((360.0/100.0)* horsePercentage[i]))
		lastAngle = horseAngle[i]

func AddValueHorseWeigh(horseNum:float,value:float) ->void:
	horseWeigh[horseNum]= horseWeigh[horseNum]+ (horseWeigh[horseNum]/100)*value
	print((horseWeigh[horseNum]/100)*value)
	var total =0.0
	var lastAngle = 0.0
	var totalAngle = 0.0
	for i in range(len(horseWeigh)):
		total +=horseWeigh[i]
	for i in range(len(horseWeigh)):
		horsePercentage[i]=(horseWeigh[i]/(total/100.0))
	for i in range(len(horseWeigh)):
		horseAngle[i] =(lastAngle+((360.0/100.0)* horsePercentage[i]))
		lastAngle = horseAngle[i]
		queue_redraw()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("addTest"):
		AddValueHorseWeigh(6,-25)
		print("t")
		
func _draw() -> void:
	draw_circle(Vector2.ZERO,outer_raduis, bkg_color)
	draw_arc(Vector2.ZERO,inner_radius,0,TAU,128, line_color, line_width,true)
	if len(horseWeigh) >=3:
		for i in range(len(horseWeigh)-1):
			
			var point = Vector2.from_angle(deg_to_rad(horseAngle[i]))
			draw_line(
				point*inner_radius,
				point*outer_raduis,
				line_color,
				line_width,
				true
			)
