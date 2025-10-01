extends Node

const NUM_TRUFFLES = 10
const TRUFFLE_PATH = "res://src/Truffle.tscn"

var current_truffle: Node2D = null
var truffles_collected: int = 0
var start_time: float = 0.0
var game_time: float = 0.0

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
	start_time = Time.get_ticks_msec() / 1000.0
	SignalBus.emit_signal("on_truffles_remaining", NUM_TRUFFLES) 


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
	game_time = (Time.get_ticks_msec() / 1000.0) - start_time
	
func new_game():
	score = 0
	
	#$StartTimer.start()

	#check if collision between player & truffle
		#if <= 10 pix away, red
		#if <= 25 pix away, yellow
		#if <= 100 pix away, blue
		#if > 100 pix away, sadface



func _on_digbox_area_entered(area):
	player_touching = true
	if area.name == "truffle_zone":
		print_debug("enter")


func _on_digbox_area_exit(area):
	current_truffle = null
	player_touching = false
	if area.name == "truffle_zone":
		print_debug("leaving ",area.get_parent().name)


func _on_player_dig(area):
	if Input.is_action_pressed("action"):
		#if body.is_in_group("Truffle"):
		if player_touching == true:
			area.queue_free()
			print("deleting",area.name)
			player_touching = false
			truffles_collected += 1

			# Update remaining truffles display
			var remaining = NUM_TRUFFLES - truffles_collected
			SignalBus.emit_signal("on_truffles_remaining", remaining)

			# Check if all truffles collected
			if truffles_collected >= NUM_TRUFFLES:
				game_complete()

func game_complete():
	# Stop the background music
	if has_node("BackgroundMusic"):
		$BackgroundMusic.stop()

	# Save the completion time and go to completion screen
	GameData.completion_time = game_time
	get_tree().change_scene_to_file("res://src/GameCompleteScreen.tscn")

