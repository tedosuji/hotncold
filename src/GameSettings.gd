extends Node

# Game settings that persist across scenes
var debug_mode: bool = false

signal debug_mode_changed(enabled: bool)

func toggle_debug_mode():
	debug_mode = !debug_mode
	emit_signal("debug_mode_changed", debug_mode)

func set_debug_mode(enabled: bool):
	debug_mode = enabled
	emit_signal("debug_mode_changed", debug_mode)
