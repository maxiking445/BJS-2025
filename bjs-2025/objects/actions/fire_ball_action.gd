extends Action


func doAction():
	for fireball in get_children():
		if fireball is Fireball:
			fireball.start = true
