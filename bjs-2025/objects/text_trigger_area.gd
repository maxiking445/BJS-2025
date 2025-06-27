extends Area2D

@export var text = "UNDEFINED"

func _on_body_entered(body: Node2D) -> void:
	TextManager.createThought(Util.currentPlayer.getTextPosition(),text, false)
	
