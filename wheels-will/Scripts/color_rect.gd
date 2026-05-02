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

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(activebet == true) :
		color = Color.BROWN
		_lastbody = body
	body.bet_active = self
	print(body.bet_active)
	
func _on_area_2d_body_exited(body: Node2D) -> void:
	if(activebet == true) :
		color = Color.REBECCA_PURPLE
		_lastbody = null
	body.bet_active = null
	print(body.bet_active)
	
func bet_actions(_var : int) -> void:
	color = Color.BLACK
	print(_var)
	activebet = false

func validate_bet(_top1 : int, _top2 : int, _top3 : int) -> void:
	if(BetType == "Top1") :
		if(HorseID == _top1) :
			winningbet = true
	if(BetType == "Top2") :
		if(HorseID == _top1 || HorseID == _top2) :
			winningbet = true
	if(BetType == "Top3") :
		if(HorseID == _top1 || HorseID == _top2 || HorseID == _top3) :
			winningbet = true
	if(winningbet) :
		moneygain = bettingValue*BetMultipler
	else :
		moneygain = MalusPoint
