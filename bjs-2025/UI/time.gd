extends Control

var time_passed := 0.0

var runningForward:bool = true
@onready var label: Label = $Label

func _ready() -> void:
	SignalManager.reverseTimer.connect(on_reverse_timer)

func _process(delta: float) -> void:
	if runningForward:
		time_passed += delta
		label.text = format_time(time_passed)
	else:
		time_passed -= delta
		label.text = format_time(time_passed)		
		
func format_time(seconds: float) -> String:
	var mins = int(seconds) / 60
	var secs = int(seconds) % 60
	var millis = int((seconds - int(seconds)) * 100)
	return "%02d:%02d.%02d" % [mins, secs, millis]

func on_reverse_timer():
	if runningForward:
		runningForward = false
	else:
		runningForward = true
