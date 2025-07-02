extends TextureRect


var base_position: Vector2
var time := 0.0

func _ready():
	base_position = position
	set_process(true)

func _process(delta):
	time += delta
	var offset = sin(time * 2.0) * 5.0  # sanftes Auf und Ab
	position = base_position + Vector2(0, offset)
