extends CharacterBody2D

@export var speed: float = 80.0
@export var oscillation_amplitude: float = 6.0
@export var oscillation_speed: float = 3.0

var direction: int = 1
var time_passed: float = 0.0
var base_y: float
var is_flying_left:bool = true

func _ready():
	base_y = global_position.y

func _physics_process(delta):
	time_passed += delta

	# Horizontal movement
	velocity.x = speed * direction

	# Vertical oscillation (does NOT affect collisions)
	velocity.y = 0
	global_position.y = base_y + sin(time_passed * oscillation_speed) * oscillation_amplitude

	move_and_slide()

	# Flip direction when hitting a wall
	if is_on_wall():
		direction *= -1
		is_flying_left = !is_flying_left
		var animation_name = "fly_" + ("right" if is_flying_left else "left")
		%AnimationPlayer.play(animation_name)
