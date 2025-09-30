extends Control

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://src/Main.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://src/OptionsMenu.tscn")

func _on_high_scores_button_pressed():
	get_tree().change_scene_to_file("res://src/HighScoresMenu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
