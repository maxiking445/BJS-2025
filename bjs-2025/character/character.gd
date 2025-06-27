extends CharacterBody2D
class_name Character

enum FACE {RIGHT, LEFT}

@export var speed: float = 200
@export var gravity := 1000.0
@export var jump_force := -400.0
@export var max_fall_speed := 900.0
var direction = Vector2.ZERO
var pushForce = 200
var pullforce = 100
var inPullMode: bool
var attachedObject: RigidBody2D
var collisionArea: Area2D = null
var pullArea: Area2D = null
var pullpoint: Marker2D = null
var currentFace: FACE = FACE.RIGHT
var isPushing= false

func _ready() -> void:
	collisionArea = $RightArea
	pullArea = $RightPullAreaa
	createThought("Where am i?")

func createThought(text: String, showOnlyOneText= true):
	TextManager.createThought($TextPosition,text, showOnlyOneText)

func _physics_process(delta):
	var x_direction := 0
	if Input.is_action_pressed("LEFT"):
		currentFace =  FACE.LEFT
		collisionArea = $LeftArea
		if !attachedObject:
			pullArea = $LeftPullArea
		if !inPullMode:
			x_direction = -1
		elif canWalkIntoDirection(FACE.LEFT):
			x_direction = -1
	elif Input.is_action_pressed("RIGHT"):
		currentFace =  FACE.RIGHT
		collisionArea = $RightArea
		if !attachedObject:
			pullArea = $RightPullArea
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
			attachedObject = null
		else:
			inPullMode = true
			if currentFace == FACE.RIGHT:
				pullpoint = $RightPullPoint
				setPullObject()
			else:
				pullpoint = $LeftPullPoint
				setPullObject()
			
	if inPullMode:
		attachedObject.global_position.x = pullpoint.global_position.x
	else:
		var test: RigidBody2D = getPushObject()
		isPushing = false
		if test:
			isPushing = true
			var direction = (test.global_position - global_position).normalized()
			direction.y = 0 
			direction = direction.normalized()  
			test.apply_central_impulse(direction * pushForce)
					
func canWalkIntoDirection(direction: FACE)-> bool:
	if direction == FACE.LEFT:
		return pullArea.name == "RightPullArea"
	if direction == FACE.RIGHT:
		return pullArea.name == "LeftPullArea"
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

func getPushObject()-> Node2D:
	if isAreaCollidingWithCrate(collisionArea):
			var bodies:  Array[Node2D] = collisionArea.get_overlapping_bodies()
			for body in bodies:
				if body is RigidBody2D:
					return body
	return null		
		
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
