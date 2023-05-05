extends Area2D

@export var death : int = 2

func _input(event):
	if Input.is_action_pressed("action") and len(get_overlapping_bodies()) > 0:
		use_dialoge()
		
func use_dialoge():
	var dialouge = get_parent().get_node("event_textbox")
	
	if dialouge:
		dialouge.start()		

func _on_tree_exited():
	SignalBus.emit_signal("on_truffle_exit", get_parent(), death)
