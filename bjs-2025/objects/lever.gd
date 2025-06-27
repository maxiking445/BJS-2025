extends Node2D

var canTriggerLever: bool = false

func _process(delta: float) -> void:
	if canTriggerLever && Input.is_action_just_pressed("ACTION"):
		$AnimatedSprite2D.play()
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	canTriggerLever = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	canTriggerLever = false
