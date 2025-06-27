extends Control
class_name ShakyText

@export var shake_intensity: int = 2
@export var text: String = "UNDEFINED"
@export var lifeTime: float = 2
@export var text_display: Enums.TEXT_DISPLAY = Enums.TEXT_DISPLAY.NORMAL
@export var FlyTextIn : bool = false
var original_position = Vector2.ZERO

func _ready() -> void:
	if FlyTextIn:
		setupFlyTextIn()
	modulate.a = 0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_IN)
	$LifeTimer.wait_time = lifeTime
	$LifeTimer.start()
	
	original_position = $Label.position
	if text_display == Enums.TEXT_DISPLAY.BACKWARDS:
		$Label.text = text.reverse()
	elif text_display == Enums.TEXT_DISPLAY.RANDOM:
		$Label.text = shuffle_string(text) 
	else:
		$Label.text = text

func setupFlyTextIn():
	var start_pos = position
	position.y += 50  
	var tween = create_tween()
	tween.tween_property(self, "position:y", start_pos.y, 0.5) \
		.set_trans(Tween.TRANS_SINE) \
		.set_ease(Tween.EASE_OUT)
	

func _process(delta: float) -> void:
	var shake_offset = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	) * shake_intensity
	$Label.position = original_position + shake_offset

func shuffle_string(text: String) -> String:
	var chars: PackedStringArray = text.split("")
	var randomWord= "".join(shuffle_array(chars))
	return randomWord

func shuffle_array(arr: PackedStringArray) -> PackedStringArray:
	var n = arr.size()
	for i in range(n - 1, 0, -1):
		var j = randi() % (i + 1)
		var temp = arr[i]
		arr[i] = arr[j]
		arr[j] = temp
	return arr


func _on_life_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_callback(self.queue_free)  # löscht das Label nach dem Ausblenden
