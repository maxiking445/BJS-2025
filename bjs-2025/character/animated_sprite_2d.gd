extends AnimatedSprite2D
class_name AnimationCharacter
@onready var character: Character = $".."

func _physics_process(delta: float) -> void:
	updateanimation(delta)

func updateanimation(delta: float) -> void:
	if not  character.is_on_floor():
		play("jump")
	elif abs(character.velocity.x) > 10:
		play("run")
	else:
		play("idle")		
	if character.isPushing:
		play("push")
	if character.inPullMode:
		play("pull")
	
	if character.velocity.x != 0 && !character.inPullMode:
		self.flip_h = character.velocity.x < 0
	
