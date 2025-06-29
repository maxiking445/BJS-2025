extends Control



var runningForward:bool = true
@onready var label: Label = $Label

func _ready() -> void:
	SignalManager.reverseTimer.connect(on_reverse_timer)

func _process(delta: float) -> void:
	if runningForward:
		Util.time_passed += delta
		label.text = Util.format_time(Util.time_passed)
	else:
		Util.time_passed -= delta
		label.text = Util.format_time(Util.time_passed)		
		


func on_reverse_timer():
	if runningForward:
		runningForward = false
	else:
		runningForward = true
