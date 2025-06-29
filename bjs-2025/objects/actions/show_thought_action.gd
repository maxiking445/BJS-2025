extends Action

@export var character: Character = null
@export var text: String = ""
@export var showItOnce:bool = true
var hasbeenShown: bool = false
func doAction():
	if showItOnce && hasbeenShown:
		return
	if character:
		hasbeenShown = true
		character.createThought(text)
