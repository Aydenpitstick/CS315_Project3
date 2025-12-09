extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = 500.0
const GRAVITY_STR = 980.0

var gravityDir = Vector2.DOWN
var grav = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("grav_lock") and is_on_floor():
		grav = !grav
		if grav == true:
			$AnimatedSprite2D.play("Grav")
			await $AnimatedSprite2D.animation_finished
			$AnimatedSprite2D.play("Grav_Hold")
			
		if grav == false:
			$AnimatedSprite2D.play("Grav_End")
			await $AnimatedSprite2D.animation_finished

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += gravityDir * GRAVITY_STR * delta
		if grav == false:
			$AnimatedSprite2D.play("Jump")

	if Input.is_action_just_pressed("grav_right") and grav == true and is_on_floor():
		gravityDir = gravityDir.rotated(deg_to_rad(90))
	if Input.is_action_just_pressed("grav_left") and grav == true and is_on_floor():
		gravityDir = gravityDir.rotated(deg_to_rad(-90))
		
	self.rotation = lerp_angle(self.rotation, gravityDir.angle() + deg_to_rad(-90), 0.1)

		
	if grav == false:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity += -gravityDir * JUMP_VELOCITY
		
		var direction := Input.get_axis("left", "right")
		var rightVector := gravityDir.rotated(-PI/2)
		if direction:
			velocity = velocity.slide(rightVector) + rightVector * direction * SPEED
			if is_on_floor():
				$AnimatedSprite2D.play("Walk")
			var facing := velocity.dot(rightVector)
			$AnimatedSprite2D.flip_h = facing < 0
		else:
			velocity = velocity.slide(rightVector)
			if is_on_floor():
				$AnimatedSprite2D.play("Idle")
	up_direction = -gravityDir
	move_and_slide()

func _on_spikes_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
