extends Action

@onready var respawn_scene = load("res://UI/RespawnScene.tscn")

func doAction():
	print("TEST")
	var respawn_instance = respawn_scene.instantiate()
	$Camera2D/UI.add_child(respawn_instance)
