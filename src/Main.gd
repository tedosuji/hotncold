extends Node

const NUM_TRUFFLES = 10
const TRUFFLE_PATH = "res://src/Truffle.tscn"

var current_truffle: Node2D = null
var truffles_collected: int = 0
var start_time: float = 0.0
var game_time: float = 0.0
var debug_arrow: Polygon2D = null
var truffle_labels: Array = []

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
	print("Main ready - emitting initial truffles remaining: ", NUM_TRUFFLES)
	SignalBus.emit_signal("on_truffles_remaining", NUM_TRUFFLES)
	create_debug_arrow()
	GameSettings.debug_mode_changed.connect(_on_debug_mode_changed)

	# Connect digbox signals from pig player
	var pig = $Node2D/pigPlayer2
	if pig and pig.has_node("digbox"):
		var digbox = pig.get_node("digbox")
		digbox.area_entered.connect(_on_digbox_area_entered)
		digbox.area_exited.connect(_on_digbox_area_exit) 


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
	update_debug_arrow()

	# Check for escape key to return to main menu
	if Input.is_action_just_pressed("pause"):
		return_to_main_menu()
	
func new_game():
	score = 0
	
	#$StartTimer.start()

	#check if collision between player & truffle
		#if <= 10 pix away, red
		#if <= 25 pix away, yellow
		#if <= 100 pix away, blue
		#if > 100 pix away, sadface



func _on_digbox_area_entered(area):
	print("Digbox entered area: ", area.name)
	player_touching = true
	if area.name == "truffle_zone":
		current_truffle = area.get_parent()
		print("Current truffle set to: ", current_truffle.name if current_truffle else "null")


func _on_digbox_area_exit(area):
	print("Digbox exited area: ", area.name)
	current_truffle = null
	player_touching = false
	if area.name == "truffle_zone":
		print("Leaving truffle zone: ", area.get_parent().name)


func _on_player_dig(area):
	if Input.is_action_just_pressed("action"):
		#if body.is_in_group("Truffle"):
		if player_touching == true and area != null:
			print("Digging truffle: ", area.name)
			area.queue_free()
			player_touching = false
			current_truffle = null
			truffles_collected += 1

			# Update remaining truffles display
			var remaining = NUM_TRUFFLES - truffles_collected
			print("Truffles collected: ", truffles_collected, " / ", NUM_TRUFFLES)
			print("Emitting truffles remaining signal: ", remaining)
			SignalBus.emit_signal("on_truffles_remaining", remaining)

			# Check if all truffles collected
			if truffles_collected >= NUM_TRUFFLES:
				print("All truffles collected! Completing game...")
				game_complete()

func game_complete():
	# Stop the background music
	if has_node("BackgroundMusic"):
		$BackgroundMusic.stop()

	# Save the completion time and go to completion screen
	GameData.completion_time = game_time
	get_tree().change_scene_to_file("res://src/GameCompleteScreen.tscn")

func create_debug_arrow():
	# Create a skinny arrow shape pointing right
	debug_arrow = Polygon2D.new()
	var arrow_points = PackedVector2Array([
		Vector2(0, -3),
		Vector2(25, 0),
		Vector2(0, 3)
	])
	debug_arrow.polygon = arrow_points
	debug_arrow.color = Color(1, 0, 0, 0.9)  # Red with some transparency
	debug_arrow.z_index = 100
	$Node2D/pigPlayer2.add_child(debug_arrow)

func update_debug_arrow():
	if debug_arrow == null:
		return

	# Only show arrow in debug mode
	if not GameSettings.debug_mode:
		debug_arrow.visible = false
		return

	var player = $Node2D/pigPlayer2
	if player == null:
		return

	# Find all remaining truffles
	var truffles = get_tree().get_nodes_in_group("Truffle")
	if truffles.size() == 0:
		debug_arrow.visible = false
		return

	# Find closest truffle
	var closest_truffle = null
	var min_distance = INF

	for truffle in truffles:
		var distance = player.global_position.distance_to(truffle.global_position)
		if distance < min_distance:
			min_distance = distance
			closest_truffle = truffle

	if closest_truffle != null:
		debug_arrow.visible = true
		# Calculate direction to truffle
		var direction = (closest_truffle.global_position - player.global_position).normalized()
		# Set arrow rotation to point at truffle
		debug_arrow.rotation = direction.angle()
		# Position arrow offset from player center
		debug_arrow.position = Vector2(30, -20)
	else:
		debug_arrow.visible = false

func _on_debug_mode_changed(enabled: bool):
	# Update truffle location labels
	update_truffle_labels()

func update_truffle_labels():
	# Clear existing labels
	for label in truffle_labels:
		if is_instance_valid(label):
			label.queue_free()
	truffle_labels.clear()

	if not GameSettings.debug_mode:
		return

	# Create labels for all truffles
	var truffles = get_tree().get_nodes_in_group("Truffle")
	for truffle in truffles:
		var label = Label.new()
		label.text = "X"
		label.modulate = Color(1, 0, 0)  # Red color
		label.z_index = 100
		label.scale = Vector2(2, 2)
		truffle.add_child(label)
		label.position = Vector2(-10, -30)
		truffle_labels.append(label)

func return_to_main_menu():
	# Stop the background music
	if has_node("BackgroundMusic"):
		$BackgroundMusic.stop()
	get_tree().change_scene_to_file("res://src/MainMenu.tscn")
