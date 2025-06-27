extends Node2D

var canTriggerLever: bool = false
var leverIsPulled: bool = false
var messagePrinted: bool = false

func _process(delta: float) -> void:
	if !leverIsPulled &&  canTriggerLever && Input.is_action_just_pressed("ACTION"):
		leverIsPulled = true
		$AnimatedSprite2D.play()
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	canTriggerLever = true
	if body is Character:
		if !messagePrinted:
			messagePrinted = true
			body.createThought("Oh a Lever what happens if I press it?")


func _on_area_2d_body_exited(body: Node2D) -> void:
	canTriggerLever = false
