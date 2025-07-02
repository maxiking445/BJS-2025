extends Action

@export var pressurePlate: PressurePlate


func doAction():
	if !Util.isInReplayMode:
		pressurePlate._on_flip()
		pressurePlate.sendPressedEvent = false
