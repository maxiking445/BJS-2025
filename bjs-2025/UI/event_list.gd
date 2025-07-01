extends Control

@onready var eventItem_scene = preload("res://UI/EventItem.tscn")

func _ready() -> void:
	$HBoxContainer.size_flags_horizontal = Control.SIZE_EXPAND
	SignalManager.pressedButton.connect(on_button_event)

func on_button_event(time: String, displayText: String):
	if Util.isInReplayMode && findItemInRow(displayText):
		var item = findItemInRow(displayText)
		item.queue_free()
	var eventItem = eventItem_scene.instantiate()
	eventItem.text = displayText
	eventItem.time = time
	$HBoxContainer.add_child(eventItem)

func findItemInRow(displayText: String)-> EventItem:
	for item: EventItem in $HBoxContainer.get_children():
		if item.text == displayText:
			return item
	return null
