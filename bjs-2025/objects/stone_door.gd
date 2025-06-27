extends Node2D

@export var openDoorButton: PressurePlate
@export var closeDootButton: PressurePlate

@export var sink_amount := 100
@export var sink_duration := 1    
var original_position = position

func  _ready() -> void:
	openDoorButton.pressed.connect(on_button_pressed)
	if !closeDootButton:
		openDoorButton.loose.connect(on_button_loose)
	else:
		closeDootButton.loose.connect(on_button_loose)
	original_position = position
	
func on_button_pressed():
	var tween = create_tween()
	tween.tween_property(self, "position", original_position + Vector2(0, sink_amount), sink_duration)

func on_button_loose():
	var tween = create_tween()
	tween.tween_property(self, "position", original_position, sink_duration)
