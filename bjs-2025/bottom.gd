extends Node2D

var time_passed := 0.0
@onready var water = $Water
var max_bodies = 70
var current_bodies = 0

@onready var deadBody_scene = preload("res://character/deadBody.tscn")

func _process(delta):
	time_passed += delta
	if water.material is ShaderMaterial:
		water.material.set_shader_parameter("time", time_passed)
		
	for body in $Bodys.get_children():
		body.position.x -= randi_range(0.1, 1.2)
		



func _on_spawn_timer_timeout() -> void:
	if current_bodies < max_bodies:
		var randomSpawnKey = randi_range(0, $Spawns.get_child_count()-1)
		var spawnLocation = $Spawns.get_child(randomSpawnKey)
		var body = deadBody_scene.instantiate()
		body.position = spawnLocation.position
		$Bodys.add_child(body)
	current_bodies = $Bodys.get_child_count()

		


func _on_area_2d_area_entered(area: Area2D) -> void:
		print("FREE THEM")
		area.queue_free()


func _on_respawn_timer_timeout() -> void:
	$RespawenArea/RespawnAction.doAction()


func _on_respawen_area_body_entered(body: Node2D) -> void:
	$RespawenArea/RespawnTimer.start()
