extends Action

@export var pressurePlate: PressurePlate

func doAction():
	pressurePlate.sink()
