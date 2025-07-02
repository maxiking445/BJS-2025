extends Node

var isRespawenScrenOpen: bool = false
@export var action: Action

func _ready() -> void:
	SignalManager.reverseTimer.connect(reset)
	
func _process(delta: float) -> void:
		var ghost: GhostCharacter = findGhostCharacter()
		if ghost:
			var min_distance := 100.0
			var max_distance := 1000.0
			var distance = $"../Character".position.distance_to(ghost.position)
			var strength = clamp((distance - min_distance) / (max_distance - min_distance), 0.0, 10)
			if !isRespawenScrenOpen:
				$"../Character/Camera2D".start_shake(strength*10, 0.3)
			if distance > 800:
				if !isRespawenScrenOpen:
					isRespawenScrenOpen = true
					
					action.doAction()
		
func findGhostCharacter()-> GhostCharacter:
	for node in $"..".get_children():
		if node is GhostCharacter:
			return node
	return null		

func reset():
	isRespawenScrenOpen = false
	
