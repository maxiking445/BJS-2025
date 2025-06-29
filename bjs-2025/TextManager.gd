extends Node

@onready var text_scene = preload("res://UI/shaky_text.tscn")
var lastTextCreated: Node = null

func createThought(parent: Node2D, text: String, showOnlyOneText: bool = true):
	if checkIfATextIsAlreadyDisplayed() && showOnlyOneText:
		print("TEXT EXISTS: ", lastTextCreated)
		return
	var instance: ShakyText = text_scene.instantiate()
	instance.FlyTextIn = true
	instance.lifeTime = 3
	instance.text = text
	instance.text_display = Enums.TEXT_DISPLAY.NORMAL
	instance.shake_intensity = 0
	parent.add_child(instance)
	lastTextCreated = instance
	

func createText(parent: Node2D, text: String, textDisplay: Enums.TEXT_DISPLAY, shake_intensity: int):
	var instance: ShakyText = text_scene.instantiate()
	instance.FlyTextIn = true
	instance.lifeTime = 5
	instance.text = text
	instance.text_display = textDisplay
	instance.shake_intensity = shake_intensity
	parent.add_child(instance)

		
func checkIfATextIsAlreadyDisplayed()-> bool:
	if is_instance_valid(lastTextCreated):
		return true
	else:
		return false
