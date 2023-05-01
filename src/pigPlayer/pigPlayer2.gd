extends CharacterBody2D


@export var SPEED: int = 300

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree

# Get the gravity from the project settings to be synced with RigidBody nodes.
var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true

func updateAnimation():
	if direction.x != 0:
		animation_tree.set("parameters/walk/blend_position", direction.x)
	else:
		animation_tree.set("parameters/walk/blend_position", direction.y)
		
func _physics_process(delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	
	var state_machine = $AnimationTree.get("parameters/playback")
	
	state_machine.travel("walk")
	if direction.x < 0:
		sprite.flip_h = false
		
	elif direction.x > 0:
		sprite.flip_h = true
		
	#if direction.y != 0:
		#state_machine.travel("walk")
	if Input.is_action_pressed("action"):
		state_machine.travel("dig")	
	
	move_and_slide()
	updateAnimation()	


func _on_digbox_area_entered(area):
	
	if area.name == "truffle_zone":
		print_debug(area.get_parent().name)
		# Check if the "Z" key is pressed
		if Input.is_action_pressed("ui_cancel"):
			# Delete the sprite
			area.queue_free()
