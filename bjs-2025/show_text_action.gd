extends Action


@export var text: String = ""
@export var shakeIntensity: int = 0
var actionPlayed: bool = false
var displayText:Enums.TEXT_DISPLAY 

func doAction():
	if Util.isInReplayMode:
		displayText = Enums.TEXT_DISPLAY.NORMAL
	else:
		displayText = Enums.TEXT_DISPLAY.RANDOM
		
	TextManager.createText($TextPosition,text,displayText, shakeIntensity)
