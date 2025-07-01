extends Node2D
@onready var menue_scene = preload("res://UI/gameMenue.tscn")

@export var debugMode = true

func _ready() -> void:
	if !debugMode:
		$ColorRect.show()
		$Bedroom/ColorRect.show()
	fadeOutCanvasLayer()
	Util.time_passed = 6

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("MENUE"):
		if !isMenueOpen():
			var menue_instance = menue_scene.instantiate()
			$Character/Camera2D/UI.add_child(menue_instance)
			var dict: Array[Dictionary] = []
			for record: ReplayObject in $RecordingManager.recording:
				dict.append(record.to_dict($Character, get_tree()))
			saveReplay(dict)
			get_tree().paused = true

@export var saveFolder = "/REPLAYDATA"
@export var saveGameRootFolder = OS.get_environment("HOME")
func saveReplay(replay_data):
	ensure_folder_exists()
	var file = FileAccess.open(saveGameRootFolder +  "/" +  saveFolder + "/" + "data"   + ".json", FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(replay_data)
		file.store_string(json_string)
		file.close()
	else:
		print("Fehler beim Öffnen der Datei!")
		
func ensure_folder_exists() -> void:
	var dir = DirAccess.open( saveGameRootFolder + saveFolder)
	if dir == null:
		DirAccess.make_dir_recursive_absolute( saveGameRootFolder + saveFolder) 	
		
func fadeOutCanvasLayer():
	var tween = create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0.0, 10.0) # 1 Sekunde ausfaden

func isMenueOpen()-> bool:
	for uiItem in $Character/Camera2D/UI.get_children() :
		if uiItem is GameMenue:
			return true
	return false
