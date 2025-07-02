extends Control
class_name GameMenue


func _ready() -> void:
	pass

func _on_resume_button_pressed() -> void:
	self.queue_free()


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/mainmenue.tscn")


func _on_respawn_button_pressed() -> void:
	var current_scene = get_tree().current_scene
	get_tree().reload_current_scene()
	Util.time_passed = 0.0
	print(Util.respawnCount)
	Util.respawnCount += 1 
