extends CharacterBody2D

@export var speed: float = 200
@export var gravity := 1000.0
@export var jump_force := -400.0
@export var max_fall_speed := 900.0
var direction = Vector2.ZERO


func _physics_process(delta):
	var x_direction := 0
	if Input.is_action_pressed("LEFT"):
		x_direction = -1
	elif Input.is_action_pressed("RIGHT"):
		x_direction = 1
	else:
		x_direction = 0
	
	velocity.x = x_direction * speed
	
	
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, max_fall_speed)
	else:
		if Input.is_action_just_pressed("JUMP"):
			velocity.y = jump_force
		else: 
			velocity.y = 0
	
	move_and_slide()

	
