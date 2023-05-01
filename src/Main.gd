extends Node

const NUM_TRUFFLES = 10
const TRUFFLE_PATH = "res://src/Truffle.tscn"

var current_truffle: Node2D = null

@export var mob_scene: PackedScene
var score
var screen_size
var player_touching = null

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
		var x = randi_range(75, get_viewport().get_visible_rect().size.x-100)
		var y = randi_range(100, get_viewport().get_visible_rect().size.y-100)
		truffle.position = Vector2(x, y)
		add_child(truffle)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_on_player_dig(current_truffle)

func new_game():
	score = 0
	$pigPlayer2.position = $PlayerStart.position
	$StartTimer.start()

	#check if collision between player & truffle
		#if <= 10 pix away, red
		#if <= 25 pix away, yellow
		#if <= 100 pix away, blue
		#if > 100 pix away, sadface


func _on_player_body_entered(body):
	current_truffle = body
	player_touching = true
	print("touching, ", player_touching)


func _on_player_body_exited(body):
	current_truffle = null
	player_touching = false
	print("not touching, ", player_touching)


func _on_player_dig(body):
	if Input.is_action_pressed("action"):
		#if body.is_in_group("Truffle"):
		if player_touching == true:
			body.queue_free()
			print("deleting",body.name)
			player_touching = false
			
