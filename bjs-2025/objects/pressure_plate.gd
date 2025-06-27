extends Node2D

@export var sink_amount := 5.0   
@export var sink_duration := 0.1       
@export var riseTimer : float = 2
   
var is_pressed := false
var original_position := Vector2.ZERO

func _ready() -> void:
	$RiseTImer.wait_time = riseTimer
	original_position = position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not is_pressed:
		is_pressed = true
		sink()

func sink() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position", original_position + Vector2(0, sink_amount), sink_duration)
	$RiseTImer.start()

func rise() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position", original_position, sink_duration)


func _on_rise_t_imer_timeout() -> void:
	if !isSomethingOnButton():
		is_pressed = false
		rise()
	else:
		$RiseTImer.start()
		
func isSomethingOnButton()-> bool:
	for body in $Area2D.get_overlapping_bodies():
		if body is RigidBody2D || body is CharacterBody2D:
			return true
	return false	
		
