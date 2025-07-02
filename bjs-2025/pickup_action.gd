extends Action

@export var item:Node
@export var char: Character = null
var hasBeenActivated: bool = false
func doAction():
	if !hasBeenActivated:
		hasBeenActivated = true
		item.queue_free()
		char.addWeapon()
