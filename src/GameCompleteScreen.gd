extends Control

@onready var time_label = $VBoxContainer/TimeLabel
@onready var high_score_label = $VBoxContainer/HighScoreLabel
@onready var name_label = $VBoxContainer/NameLabel
@onready var name_input = $VBoxContainer/NameInput
@onready var submit_button = $VBoxContainer/SubmitButton
@onready var menu_button = $VBoxContainer/MenuButton

var completion_time: float = 0.0
var is_high_score: bool = false

func _ready():
	completion_time = GameData.completion_time
	time_label.text = "Your Time: " + GameData.format_time(completion_time)

	# Check if this is a high score
	is_high_score = GameData.is_high_score(completion_time)

	if is_high_score:
		high_score_label.visible = true
		name_label.visible = true
		name_input.visible = true
		submit_button.visible = true
		menu_button.visible = false
		name_input.grab_focus()
	else:
		menu_button.visible = true

func _on_submit_button_pressed():
	var player_name = name_input.text.strip_edges()
	if player_name == "":
		player_name = "Player"

	GameData.add_high_score(player_name, completion_time)
	get_tree().change_scene_to_file("res://src/MainMenu.tscn")

func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://src/MainMenu.tscn")
