extends ColorRect
var activebet = true
var _lastbody : Node2D = null
@export var BetMultipler : int = 0
@export var MalusPoint : int = 0
@export_range(0,5) var HorseID : int = 0
@export_enum("Top1","Top2","Top3") var BetType: String = "Top1"
var bettingValue : int = 0
var moneygain : int = 0
var winningbet : bool = false

func _ready() -> void:
	$betmultiplayer.text = "x"+str(BetMultipler)
	if MalusPoint != 0 :
		$malus.text = str(MalusPoint)
	else :
		$malus.hide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(activebet == true) :
		_lastbody = body
		color = Color.REBECCA_PURPLE
	body.bet_active = self
	print(body.bet_active)
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if(activebet == true) :
		_lastbody = null
		color = Color.WHITE
	body.bet_active = null
	
func bet_actions(_var : int) -> void:
	activebet = false

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
		_lastbody.score += moneygain
		print("Winnings ",_lastbody.player_index," :",_lastbody.score)
