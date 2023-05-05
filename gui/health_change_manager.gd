extends Control

@export var itembar_text : PackedScene

func _ready():
	SignalBus.connect("on_health_changed", on_signal_health_changed)
	#SignalBus.connect("on_digbox_entered", digbox_signaled)
	
func _process(delta):
	pass

func on_signal_health_changed(node: Node, amount_changed: int):
	var label_instance: Label = itembar_text.instantiate()
	node.add_child(label_instance)
	#breakpoint
	#if absi(amount_changed) == 5:
		#breakpoint
	#	label_instance.text = "Found it!"
	
	#elif absi(amount_changed) == 0:
	#	#breakpoint
	#	label_instance.text = "It's close."	
	
#func digbox_signaled(node: Node, visible: int):
#	if absi(visible) == 1:	
#		print_debug(" digbox in")
