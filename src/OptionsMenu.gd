extends Control

@onready var debug_checkbox = $VBoxContainer/DebugCheckBox

func _ready():
	# Set checkbox to current debug mode state
	debug_checkbox.button_pressed = GameSettings.debug_mode

func _on_debug_check_box_toggled(toggled_on: bool):
	GameSettings.set_debug_mode(toggled_on)
	print("Debug mode set to: ", toggled_on)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://src/MainMenu.tscn")
