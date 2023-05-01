extends CharacterBody2D


@export var SPEED: int = 300

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree

# Get the gravity from the project settings to be synced with RigidBody nodes.
var direction : Vector2 = Vector2.ZERO

func handleInput():
	var movedirection = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = movedirection * SPEED

func updateAnimation():
	animation_tree.set("parameters/walk/blend_position", direction.x)

func _physics_process(delta):
	handleInput()
	move_and_slide()
	updateAnimation()
