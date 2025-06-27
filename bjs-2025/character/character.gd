extends CharacterBody2D
class_name Character

enum FACE {RIGHT, LEFT}

@export var speed: float = 200
@export var gravity := 1000.0
@export var jump_force := -400.0
@export var max_fall_speed := 900.0
var direction = Vector2.ZERO
var pushForce = 1000

var inPullMode: bool
var attachedObject: RigidBody2D
var pullArea: Area2D = null
var pullpoint: Marker2D = null
var currentFace: FACE = FACE.RIGHT
var isPushing= false

func _ready() -> void:
	TextManager.createThought($TextPosition, "Where am i?")

func _physics_process(delta):
	var x_direction := 0
	if Input.is_action_pressed("LEFT"):
		currentFace =  FACE.LEFT
		if !inPullMode:
			x_direction = -1
		elif canWalkIntoDirection(FACE.LEFT):
			x_direction = -1
	elif Input.is_action_pressed("RIGHT"):
		currentFace =  FACE.RIGHT
		if !inPullMode:
			x_direction = 1
		elif canWalkIntoDirection(FACE.RIGHT):
			x_direction = 1
	else:
		x_direction = 0
	
	velocity.x = x_direction * speed
	
	handleJump(delta)
	
	move_and_slide()
	if Input.is_action_just_pressed("PULL"):
		if inPullMode:
			inPullMode = false
		else:
			inPullMode = true
			if currentFace == FACE.RIGHT:
				pullArea = $RightArea
				pullpoint = $RightPullPoint
				setPullObject()
			else:
				pullArea = $LeftArea
				pullpoint = $LeftPullPoint
				setPullObject()
			
	if inPullMode:
		var target_x = pullpoint.global_position.x
		var current_pos = attachedObject.global_position
		attachedObject.global_position.x = move_toward(current_pos.x, target_x, 300 * delta)
	else:
		pullArea
		for i in get_slide_collision_count():
			isPushing = false
			var collision = get_slide_collision(i)
			if collision.get_collider() is RigidBody2D:
					isPushing = true
					collision.get_collider().apply_central_impulse(-collision.get_normal() * pushForce)
					
func canWalkIntoDirection(direction: FACE)-> bool:
	if direction == FACE.LEFT:
		return pullArea.name == "RightArea"
	if direction == FACE.RIGHT:
		return pullArea.name == "LelftArea"
	return false
func handleJump(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)
	else:
		if Input.is_action_just_pressed("JUMP"):
			velocity.y = jump_force
		else: 
			velocity.y = 0
	
func setPullObject():
	if getPullObject():
		attachedObject = getPullObject()
	else:
		inPullMode = false	
		
func getPullObject()-> Node2D:
	if isAreaCollidingWithCrate(pullArea):
			var bodies:  Array[Node2D] = pullArea.get_overlapping_bodies()
			for body in bodies:
				if body is RigidBody2D:
					return body
	return null				
	
func isAreaCollidingWithCrate(area: Area2D) -> bool:
	return area.has_overlapping_bodies()

func getTextPosition()-> Marker2D:
	return $TextPosition
