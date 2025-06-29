extends Control

func _ready() -> void:
	pass

func _on_resume_button_pressed() -> void:
	self.queue_free()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
