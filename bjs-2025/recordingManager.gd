extends Node2D
class_name RecordingManager


var recording: Array[ReplayObject] = []

@export var isRecording = true
@export var isReplaying = false
@onready var character:Character = $"../Character"
@onready var ghostChar:GhostCharacter = null
var current_frame := 0	

func _physics_process(delta: float) -> void:
	if isRecording:
		record()
	if isReplaying:
		replay(delta)
	
func record():
		var frame = ReplayObject.new()
		frame.position = character.position
		frame.velocity = character.velocity
		frame.animation = character.getCurrentAnimation()
		#crates
		
		for object in get_tree().get_nodes_in_group("Object"):
			var crates : Dictionary[String, Vector2] = {}
			crates[object.name] = object.global_position 
			frame.crates.append(crates)
			
		
		for plate in get_tree().get_nodes_in_group("Plate"):
			var pressurePlates : Dictionary[String, bool] = {}
			pressurePlates[plate.name] = plate.is_pressed
			frame.pressurePlates.append(pressurePlates)
			
		recording.append(frame)
		
		

func replay(delta):
	if current_frame < recording.size():
		var frame = recording[current_frame]
		ghostChar.replay(frame,delta)
		#crates
		for object in get_tree().get_nodes_in_group("Object"):
				var cratePos = getPositionByName(frame.crates,object.name )
				object.set_deferred("global_position", cratePos)
		#plates
		for object in get_tree().get_nodes_in_group("Plate"):
			var plateIsPressed = getBoolByName(frame.pressurePlates,object.name )
			object.replay(plateIsPressed) 
		current_frame += 1
	else:
		print("REPLAY FINISHED!")
		ghostChar.queue_free()
		isRecording = true
		isReplaying = false
		
func getPositionByName(data: Array, name: String) -> Vector2:
	for entry in data:
		if name in entry:
			return entry[name]
	return Vector2.ZERO
	
func getBoolByName(data: Array, name: String) -> bool:
	for entry in data:
		if name in entry:
			return entry[name]
	return false	
	
func reverseOrder():
	recording.reverse()
	var playback = recording
	recording = playback
