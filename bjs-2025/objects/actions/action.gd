extends Node2D
class_name Action

@export var nextAction: Action

func doAction():
	pass

func doNextAction():
	nextAction.doAction()
