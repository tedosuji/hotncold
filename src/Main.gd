extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("dig"):
		player_dig()
		#check if collision between player & truffle
		#if <= 10 pix away, red
		#if <= 25 pix away, yellow
		#if <= 100 pix away, blue
		#if > 100 pix away, sadface
		pass


func player_dig():
	pass # Replace with function body.
