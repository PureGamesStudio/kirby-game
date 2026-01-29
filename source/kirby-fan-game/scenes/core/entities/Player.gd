extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const TERMINAL_VELOCITY = 1000.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		# terminal velocity...
		if velocity.y > TERMINAL_VELOCITY:
			velocity.y = TERMINAL_VELOCITY

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		var direction_name = "left" if direction < 0 else "right"
		%AnimationPlayer.play("walk_" + direction_name)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity == Vector2.ZERO:
		%AnimationPlayer.stop()

	move_and_slide()
