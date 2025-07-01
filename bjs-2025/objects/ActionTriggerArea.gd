extends Area2D

@export var action: Action = null
@export var length: int = 0
func _ready() -> void:
	if length != 0:
		$CollisionShape2D.shape.size.x = length
	

func _on_body_entered(body: Node2D) -> void:
	action.doAction()
	
