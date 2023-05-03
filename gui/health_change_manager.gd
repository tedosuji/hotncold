extends Control

@export var item_textbox : PackedScene

func _ready():
	SignalBus.connect("on_health_changed", on_signal_health_changed)

func _process(delta):
	pass

func on_signal_health_changed(node: Node, amount_changed: int):
	var label_instance: Label = item_textbox.instantiate()
	node.add_child(label_instance)
	#breakpoint
	if absi(amount_changed) == 5:
		#breakpoint
		label_instance.text = "Found it!"
	
	elif absi(amount_changed) == 0:
		#breakpoint
		label_instance.text = "It's close."	
	

