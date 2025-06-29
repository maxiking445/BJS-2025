extends Camera2D


@export var shake_intensity: float = 5.0
@export var shake_duration: float = 0.3

var shake_timer := 0.0

func _ready() -> void:
	start_shake()

func _process(delta: float) -> void:
	if shake_timer > 0:
		shake_timer -= delta
		offset = Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
	else:
		offset = Vector2.ZERO

func start_shake(intensity := 5.0, duration := 0.3):
	shake_intensity = intensity
	shake_duration = duration
	shake_timer = duration
