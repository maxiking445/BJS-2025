extends Action
class_name SpawnGhostAction

@onready var recordingManager:RecordingManager = $"../../RecordingManager"
@onready var ghost_scene = preload("res://character/ghost_character.tscn")

func  _ready() -> void:
	recordingManager = $"../../RecordingManager"

func doAction():
	recordingManager.reverseOrder()
	var instance: GhostCharacter = ghost_scene.instantiate()
	instance.position =  $"../../Character".position
	$"../..".add_child(instance)
	recordingManager.ghostChar = instance
	recordingManager.isRecording = false
	recordingManager.isReplaying= true
	SignalManager.reverseTimer.emit()
	
