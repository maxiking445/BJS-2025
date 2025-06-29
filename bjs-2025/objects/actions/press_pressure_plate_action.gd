extends Action

@export var pressurePlate: PressurePlate
@export var isPressed: bool = false


func doAction():
	if !isPressed:
		isPressed = true
		pressurePlate.sink()
		pressurePlate.sendPressedEvent = false
