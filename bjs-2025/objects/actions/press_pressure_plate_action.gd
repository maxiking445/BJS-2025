extends Action

@export var pressurePlate: PressurePlate
@export var isPressed: bool = false


func doAction():
	if !isPressed:
		isPressed = true
		pressurePlate._on_flip()
		pressurePlate.sendPressedEvent = false
