extends Node2D
@onready var menue_scene = preload("res://UI/gameMenue.tscn")
@export var debugMode = true

func _ready() -> void:
	if !debugMode:
		$ColorRect.show()
	fadeOutCanvasLayer()
	SoundManager.fadeOutSound($HeartbeatSound, 40)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("MENUE"):
		var menue_instance = menue_scene.instantiate()
		$Character/Camera2D/UI.add_child(menue_instance)


func fadeOutCanvasLayer():
	var tween = create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0.0, 10.0) # 1 Sekunde ausfaden
