extends Node

const NUM_TRUFFLES = 10
const TRUFFLE_PATH = "res://src/Truffle.tscn"

var current_truffle: Node2D = null

@export var mob_scene: PackedScene
var score
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawn_truffles()
	#set_process_input(true)
	new_game() 


func spawn_truffles():
	for i in range(NUM_TRUFFLES):
		# Load the Truffle scene
		var truffle_scene = ResourceLoader.load(TRUFFLE_PATH)
		if not truffle_scene:
			print("Failed to load Truffle scene:", TRUFFLE_PATH)
			return
		var truffle = load(TRUFFLE_PATH).instantiate()
		# Generate a random position for the Truffle
		var x = randi_range(0, get_viewport().get_visible_rect().size.x)
		var y = randi_range(0, get_viewport().get_visible_rect().size.y)
		truffle.position = Vector2(x, y)
		add_child(truffle)
		
		
func _input_dig(event):
	if event is InputEventKey:
		if event.get_scancode == KEY_Z:
			print(event.get_scancode)
			if current_truffle != null:
				current_truffle.queue_free()

		
		
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_game():
	score = 0
	$Player.start($PlayerStart.position)
	$StartTimer.start()

	#check if collision between player & truffle
		#if <= 10 pix away, red
		#if <= 25 pix away, yellow
		#if <= 100 pix away, blue
		#if > 100 pix away, sadface


func _on_player_body_entered(body):
	current_truffle = body
	print("touching")
	# Check if the "Z" key is pressed
	#if Input.is_action_presseddd("dig"):
	# Delete the sprite
	current_truffle.queue_free()
	print("deleting",body.name)


func _on_player_body_exited(body):
	current_truffle = null
	print("not touching")
