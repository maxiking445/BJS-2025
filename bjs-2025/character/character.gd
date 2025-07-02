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
var showWeapon= false
@export var endScreen = false

@onready var respawn_scene = load("res://UI/RespawnScene.tscn")

signal die

func playEndScreenThoughts():
	createThought("What was that?", false)
	await  get_tree().create_timer(3.0).timeout
	createThought("I dreamed about a Lever.", false)
	await  get_tree().create_timer(3.0).timeout
	createThought("I want to press it!", false)
	await  get_tree().create_timer(2.0).timeout
	fadeInCanvasLayer()

func fadeInCanvasLayer():
	var tween = create_tween()
	tween.tween_property($"../../ColorRect", "modulate:a", 5, 3) # 1 Sekunde ausfaden	
	tween.connect("finished", Callable(self, "_on_fade_finished"))
	
func _on_fade_finished():
	$"../../Label".show()	
	
func _ready() -> void:
	if endScreen:
		playEndScreenThoughts()
	#var tween = create_tween()
	#rotation = deg_to_rad(-90.0) 
	#tween.tween_property(self, "rotation", deg_to_rad(0.0), 1.0)
	var audioPlayer: AudioStreamPlayer = 	SoundManager.playHeartbeat(self)
	SoundManager.fadeOutSound(audioPlayer, 30)
	collisionArea = $RightArea
	pullArea = $RightPullAreaa
	if endScreen:
		return
	if Util.respawnCount == 0:
		createThought("Where am i?")
	if Util.respawnCount == 1:
		createThought("I was here before - I have to find the end")
	if Util.respawnCount == 2:
		createThought("How can I escape?")
	if Util.respawnCount == 3:
		createThought("Stop it please!")
	if Util.respawnCount == 4:
		createThought("Help!")
	if Util.respawnCount == 5:
		createThought("Is there someone?")
	if Util.respawnCount == 6:
		createThought("Please!")
	if Util.respawnCount == 7:
		createThought("Not again...")
	if Util.respawnCount == 8:
		createThought("Nothing is real")
	if Util.respawnCount == 9:
		createThought("I am trapped")
	if Util.respawnCount > 9:
		createThought("trapped...")
		
func createThought(text: String, showOnlyOneText= true):
	TextManager.createThought($TextPosition,text, showOnlyOneText)

func determineWeapon():
	if showWeapon:
		if currentFace == FACE.LEFT:
			$TextureRectLeft.show()
			$TextureRectRight.hide()
		else:
			$TextureRectLeft.hide()
			$TextureRectRight.show()
		
func _physics_process(delta):
	determineWeapon()
	if Input.is_action_just_pressed("ACTION") && showWeapon:
		SoundManager.playShot(self)
		get_tree().change_scene_to_file("res://EndScene.tscn")
	if endScreen:
		return	
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
		var pushedObject: RigidBody2D = getPushObject()
		isPushing = false
		if pushedObject:
			isPushing = true
			
			var direction = (pushedObject.global_position - global_position).normalized()
			direction.y = 0 
			direction = direction.normalized()  
			pushedObject.apply_central_impulse(direction * pushForce)
					
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

func getCurrentAnimation()-> String:
	return $AnimatedSprite2D.animation

func addWeapon():
	showWeapon = true
	


func _on_die() -> void:
	var respawn_instance = respawn_scene.instantiate()
	$Camera2D/UI.add_child(respawn_instance)
