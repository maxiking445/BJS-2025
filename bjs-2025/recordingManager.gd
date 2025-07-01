extends Node2D
class_name RecordingManager


var recording: Array[ReplayObject] = []

@export var isRecording = true
@export var isReplaying = false
@onready var character:Character = $"../Character"
@onready var ghostChar:GhostCharacter = null
var current_frame := 0	

func _ready() -> void:
	var file = FileAccess.open("res://assets/data.json", FileAccess.READ)

	var content = file.get_as_text()
	var parsed = JSON.parse_string(content)
	for item in parsed:
		var obj = ReplayObject.new()
		obj.from_dict(item)
		recording.append(obj)
	
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
		frame.crates.append_array(frame.getAllObjects(get_tree()))
			
		#plates
		frame.pressurePlates.append_array(frame.getAllPlates(get_tree()))
			
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
		SignalManager.reverseTimer.emit()
		ghostChar.queue_free()
		isRecording = true
		isReplaying = false
		
func getPositionByName(data: Array, name: String) -> Vector2:
	for entry in data:
		if name in entry:
			if entry[name] is String:
				return parse_vector2(entry[name])
			if entry[name] is Vector2:
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


func parse_vector2(input) -> Vector2:
	match typeof(input):
		TYPE_VECTOR2:
			return input
		TYPE_DICTIONARY:
			return Vector2(input.get("x", 0), input.get("y", 0))
		TYPE_STRING:
			var s = input.strip_edges()
			s = s.replace("Vector2(", "").replace("(", "").replace(")", "")
			var parts = s.split(",", false)

			if parts.size() == 2:
				var x_str = parts[0].strip_edges()
				var y_str = parts[1].strip_edges()

				var x = float(x_str)
				var y = float(y_str)

				return Vector2(x, y)
	return Vector2.ZERO
