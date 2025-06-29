extends Action

@export var text: String = ""
var actionPlayed: bool = false

func doAction():
	if !actionPlayed:
		TextManager.createNormalText($TextPosition,text)
		actionPlayed = true
