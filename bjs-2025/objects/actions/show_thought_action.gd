extends Action

@export var character: Character = null
@export var text: String = ""

func doAction():
	if character:
		character.createThought(text)
