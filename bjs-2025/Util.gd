extends Node

var currentPlayer: Character = null
var isInReplayMode= false
var time_passed := 0.0
var respawnCount: int = 0

func _ready() -> void:
	SignalManager.reverseTimer.connect(updateCurrentTime)
	
func updateCurrentTime():
	if isInReplayMode:
		isInReplayMode = false
	else: 
		isInReplayMode = true

func getCurrentTime() -> String:
	return format_time(time_passed)


	
func format_time(seconds: float) -> String:
	var mins = int(seconds) / 60
	var secs = int(seconds) % 60
	var millis = int((seconds - int(seconds)) * 100)
	return "%02d:%02d.%02d" % [mins, secs, millis]


func getUINode()-> Control:
	var world = get_tree().root.get_node("World")
	return world.get_node("Character").get_node("Camera2D").get_node("UI")
