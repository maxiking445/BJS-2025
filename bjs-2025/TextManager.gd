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
	

func createNormalText(parent: Node2D, text: String):
	var instance: ShakyText = text_scene.instantiate()
	instance.FlyTextIn = true
	instance.lifeTime = 5
	instance.text = text
	instance.text_display = Enums.TEXT_DISPLAY.NORMAL
	instance.shake_intensity = 1
	parent.add_child(instance)

func createRandomText(parent: Node2D, text: String):
	var instance: ShakyText = text_scene.instantiate()
	instance.FlyTextIn = true
	instance.lifeTime = 8
	instance.text = text
	instance.text_display = Enums.TEXT_DISPLAY.RANDOM
	instance.shake_intensity = 1
	parent.add_child(instance)


func createBackwardText(parent: Node2D, text: String):
	var instance: ShakyText = text_scene.instantiate()
	instance.FlyTextIn = true
	instance.lifeTime = 5
	instance.text = text
	instance.text_display = Enums.TEXT_DISPLAY.BACKWARDS
	instance.shake_intensity = 1
	parent.add_child(instance)
		
func checkIfATextIsAlreadyDisplayed()-> bool:
	if is_instance_valid(lastTextCreated):
		return true
	else:
		return false
