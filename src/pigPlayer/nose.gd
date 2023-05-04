extends Node

class_name nose

func _ready():
	SignalBus.connect("on_health_changed", on_signal_health_changed)	
	
func on_signal_health_changed(node: Node, amount_changed: int):
		match amount_changed:
			absi(5):
				SignalBus.emit_signal("on_signal_changed", get_parent())
			0:
				SignalBus.emit_signal("on_signal_changed", get_parent())	
