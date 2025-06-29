extends Area2D

@export var action: Action = null


func _on_body_entered(body: Node2D) -> void:
	action.doAction()
	
