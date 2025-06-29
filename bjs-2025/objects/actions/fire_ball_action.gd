extends Action

func doAction():
	for fireball in get_children():
		if fireball is Fireball:
			fireball.speed = 400
			fireball.start = true
