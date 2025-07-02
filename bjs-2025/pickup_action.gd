extends Action

@export var item:TextureRect
@export var char: Character = null
var hasBeenActivated: bool = false
func doAction():
	if $"../..".visible:
		if !hasBeenActivated:
			hasBeenActivated = true
			item.queue_free()
			char.addWeapon()
