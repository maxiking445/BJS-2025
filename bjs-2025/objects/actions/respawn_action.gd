extends Action

@onready var respawn_scene = load("res://UI/RespawnScene.tscn")

func doAction():
	var respawn_instance = respawn_scene.instantiate()
	Util.getUINode().add_child(respawn_instance)
