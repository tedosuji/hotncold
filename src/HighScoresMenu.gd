extends Control

@onready var scores_list = $VBoxContainer/ScoresList

func _ready():
	display_high_scores()

func display_high_scores():
	if GameData.high_scores.size() == 0:
		scores_list.text = "No high scores yet!\nPlay the game to set a record!"
	else:
		var score_text = ""
		for i in range(GameData.high_scores.size()):
			var score = GameData.high_scores[i]
			score_text += "%d. %s - %s\n" % [i + 1, score.name, GameData.format_time(score.time)]
		scores_list.text = score_text.strip_edges()

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/MainMenu.tscn")
