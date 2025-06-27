extends AnimatedSprite2D
class_name AnimationCharacter
@onready var character: Character = $".."

func _physics_process(delta: float) -> void:
	updateanimation(delta)

func updateanimation(delta: float) -> void:
	

	var anim := ""

	if character.isPushing:
		anim = "push"
	elif character.inPullMode:
		anim = "pull"
	elif not character.is_on_floor():
		anim = "jump"
	elif abs(character.velocity.x) > 10:
		anim = "run"
	else:
		anim = "idle"

	if animation != anim:
		play(anim)
	
	if character.velocity.x != 0 && !character.inPullMode:
		self.flip_h = character.velocity.x < 0
	
