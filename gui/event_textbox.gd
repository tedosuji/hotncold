extends Control

#const items_textbox = "res://gui/items_textbox.tscn"
@export var itembar_text : PackedScene

func _ready():
	SignalBus.connect("on_health_changed", on_signal_health_changed)

func _process(delta):
	pass

func on_signal_health_changed(node: Node, amount_changed: int):
	var label_instance: Label = itembar_text.instantiate()
	#var truffle = load(items_textbox).instantiate()
	node.add_child(label_instance)
	label_instance.text = str(amount_changed)

	
		
