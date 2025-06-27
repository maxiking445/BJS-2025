extends Character
class_name GhostCharacter

func replay(frame:ReplayObject, delta):
		global_position = frame.position
		velocity = frame.velocity
		$AnimatedSprite2D.updateanimationGhost(delta, frame.animation)
		
