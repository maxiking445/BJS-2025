extends Node2D

@export var action: Action = null

var canTriggerLever: bool = true
var leverIsPulled: bool = false

func _process(delta: float) -> void:
	if !leverIsPulled &&  canTriggerLever && Input.is_action_just_pressed("ACTION"):
		leverIsPulled = true
		$AnimatedSprite2D.play()
		if action:
			action.doAction()
		

	

func _on_area_2d_body_exited(body: Node2D) -> void:
	canTriggerLever = false
