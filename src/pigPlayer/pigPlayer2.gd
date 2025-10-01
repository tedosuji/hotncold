extends CharacterBody2D

signal pig2

@export var SPEED: int = 300

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree

# Get the gravity from the project settings to be synced with RigidBody nodes.
var direction : Vector2 = Vector2.ZERO
var is_digging: bool = false
var dig_timer: Timer
var dig_start_time: float = 0.0

func _ready():
	animation_tree.active = true

	# Setup dig timer
	dig_timer = Timer.new()
	dig_timer.wait_time = 0.6
	dig_timer.one_shot = true
	dig_timer.timeout.connect(stop_digging)
	add_child(dig_timer)

	# Ensure pig starts in walk/idle state
	var state_machine = animation_tree.get("parameters/playback")
	state_machine.travel("walk")

func updateAnimation():
	if direction.x != 0:
		animation_tree.set("parameters/walk/blend_position", direction.x)
	else:
		animation_tree.set("parameters/walk/blend_position", direction.y)
		
func _physics_process(delta):
	var state_machine = $AnimationTree.get("parameters/playback")

	# Handle digging action
	if Input.is_action_just_pressed("action") and not is_digging:
		is_digging = true
		dig_start_time = Time.get_ticks_msec() / 1000.0
		state_machine.travel("dig")
		dig_timer.start()

	# Check for early dig cancel
	if is_digging:
		# Allow canceling dig early with action button (after 0.3 seconds to prevent instant cancel)
		var time_since_dig_start = (Time.get_ticks_msec() / 1000.0) - dig_start_time
		if Input.is_action_just_pressed("action") and time_since_dig_start > 0.3:
			dig_timer.stop()
			stop_digging()

	# Handle movement (only when not digging)
	if not is_digging:
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * SPEED

		if direction != Vector2.ZERO:
			state_machine.travel("walk")

		if direction.x < 0:
			sprite.flip_h = false
		elif direction.x > 0:
			sprite.flip_h = true

		updateAnimation()
	else:
		# Stop movement while digging
		velocity = Vector2.ZERO

	move_and_slide()

func stop_digging():
	is_digging = false	


						
