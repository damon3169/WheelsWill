extends Node2D
var activebet = true
var betclosed = false
var _lastbody : Node2D = null
var playerBet : Node2D = null
@export var BetMultipler : int = 0
@export var MalusPoint : int = 0
@export_range(0,5) var HorseID : int = 0
@export_enum("Top1","Top2","Top3") var BetType: String = "Top1"
var bettingValue : int = 0
var moneygain : int = 0
var winningbet : bool = false
var button = preload("res://Sprites/Enviro/BettingCase.png")
var buttonPressed = preload("res://Sprites/Enviro/BettingCasePushed.png")
var resetround


func _ready() -> void:
	resetround = get_tree().get_nodes_in_group("nextRoomButton")
	resetround[0].nextRound.connect(emit_nextRound)
	$betmultiplayer.text = "x"+str(BetMultipler)
	if MalusPoint != 0 :
		$malus.text = str(MalusPoint)
	else :
		$malus.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.bet_activeArray.append(self)
	if(activebet == true &&  betclosed == false) :
		_lastbody = body
		$Sprite2D.texture = buttonPressed
		#color = Color.REBECCA_PURPLE
	
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	body.bet_activeArray.erase(self)
	if(activebet == true && betclosed == false) :
		_lastbody = null
		$Sprite2D.texture = button
		#color = Color.WHITE

	
func bet_actions(_var : int, body:Node2D) -> void:
	activebet = false
	playerBet =body

func validate_bet(_ranklist : Array) -> void:
	if !activebet :
		if(BetType == "Top1") :
			if(HorseID == _ranklist[0]) :
				winningbet = true
		if(BetType == "Top2") :
			if(HorseID == _ranklist[0] || HorseID == _ranklist[1]) :
				winningbet = true
		if(BetType == "Top3") :
			if(HorseID == _ranklist[0] || HorseID == _ranklist[1] || HorseID == _ranklist[2]) :
				winningbet = true
		if(winningbet) :
			moneygain = bettingValue*BetMultipler
		else :
			moneygain = MalusPoint
		playerBet.score += moneygain
		print("Winnings ",playerBet.player_index," :",playerBet.score)
		

func emit_nextRound() ->void:
	activebet = true
	betclosed = false
	_lastbody = null
	playerBet = null
	bettingValue = 0
	moneygain = 0
	winningbet = false
	$Sprite2D.texture = button
pass
