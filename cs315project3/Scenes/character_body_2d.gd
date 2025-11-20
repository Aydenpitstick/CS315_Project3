extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var grav = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("Jump")
	
	if grav == false and Input.is_action_just_pressed("grav_lock") and is_on_floor():
		$AnimatedSprite2D.play("Grav")
		grav = !grav
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction > 0 and is_on_floor():
		$AnimatedSprite2D.play("Walk")
	elif direction < 0 and is_on_floor():
		$AnimatedSprite2D.flip_h
		$AnimatedSprite2D.play("Walk")

	move_and_slide()
