extends Control

@onready var eventItem_scene = preload("res://UI/EventItem.tscn")

func _ready() -> void:
	$HBoxContainer.size_flags_horizontal = Control.SIZE_EXPAND
	SignalManager.pressedButton.connect(on_button_event)

func on_button_event(time: String, displayText: String):
	var eventItem = eventItem_scene.instantiate()
	eventItem.text = displayText
	eventItem.time = time
	$HBoxContainer.add_child(eventItem)
