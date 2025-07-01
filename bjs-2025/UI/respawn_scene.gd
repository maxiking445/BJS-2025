extends Control
@onready var shakytext_scene = preload("res://UI/shaky_text.tscn")

var words = ["HATE", "FREE", "HELP", "DESIRE", "DREAM", "FLEE", "GET OUT", "HORROR", "AWAY", "ALONE", "FEAR", "DARK", "WHERE", "HOPE"]

func _ready() -> void:
	SoundManager.playWhispers($".")
	
func _process(delta: float) -> void:
	if $Texts.get_child_count() < 30:
		spawnRandomText()

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://World.tscn")
	Util.respawnCount += 1 
	Util.time_passed = 0.0


func spawnRandomText():
	var shakyText_instance: ShakyText = shakytext_scene.instantiate()
	shakyText_instance.shake_intensity = randi_range(2,8)
	shakyText_instance.text= getRandomWord(words)
	shakyText_instance.lifeTime = randi_range(2,6)
	shakyText_instance.text_display= Enums.TEXT_DISPLAY.RANDOM
	shakyText_instance.FlyTextIn = true
	randomize_position(shakyText_instance)
	$Texts.add_child(shakyText_instance)
	

func randomize_position(node: Control) -> void:
	var screen_size = get_viewport().get_visible_rect().size
	var random_x = randf_range(0, screen_size.x)
	var random_y = randf_range(0, screen_size.y)
	node.position = Vector2(random_x, random_y)

func getRandomWord(words: Array) -> String:
	var index = randi() % words.size()
	return words[index]
