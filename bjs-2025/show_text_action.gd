extends Action

@export var text: String = ""

func doAction():
	TextManager.createNormalText($Marker2D,text)
