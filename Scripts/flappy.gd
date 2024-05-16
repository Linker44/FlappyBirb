extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -20000.0
const MOVE_VELOCITY = 10000

@onready var flappybird = %Flappybird

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("fly"):
		velocity.y = JUMP_VELOCITY * delta
	if velocity.y < -70:
		flappybird.rotation_degrees = -70
	elif velocity.y > 300:
		flappybird.rotation_degrees = 70
	else:
		flappybird.rotation_degrees = 0
	move_and_slide()
