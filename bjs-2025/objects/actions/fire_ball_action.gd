extends Action

@export var fireballs: Array[Fireball] = []

func doAction():
	for fireball in fireballs:
		if fireball is Fireball:
			fireball.start = true
