@tool
extends Control

@export var text: String = "TEXT"
@export var time: String = "TIME"
func _ready() -> void:
	$HBoxContainer/VBoxContainer/TextLabel.text = text
	$HBoxContainer/VBoxContainer/TimeLabel.text = time
	
