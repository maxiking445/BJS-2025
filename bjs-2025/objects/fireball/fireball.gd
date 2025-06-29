extends Node2D
class_name Fireball
@export var speed: float = 100.0 
@export var end_y: float = 400.0
@export var start: bool = false
@export var reset_when_below: bool = true
var startpos

func _ready():
	$AnimatedSprite2D.play()
	startpos = position.y
	
	
func _process(delta: float) -> void:
	if start:
		self.show()
		position.y += speed * delta
	else:
		self.hide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Character:
		body.die.emit()
	else:
		self.queue_free()
