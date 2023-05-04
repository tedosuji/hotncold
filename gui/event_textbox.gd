extends Control


@onready var label : Label = $Panel/Label

var d_active = false

func _ready():
	$Panel.visible = false
	SignalBus.connect("on_health_changed", on_signal_health_changed)

func start():
	if d_active:
		return
	d_active = true
		
func on_signal_health_changed(node: Node, amount_changed: int):
	#var label_instance: Label = itembar_text.instantiate()
	#node.add_child(label_instance)
	#breakpoint
	if amount_changed == 0 :
		label.text = "It's close."	
		
	if amount_changed == absi(5):
		#breakpoint
			
		label.text = "Found it!"
			
	
		
		#breakpoint
			#label.text = "It's close."	
		
func _input(event):
	if Input.is_action_pressed("action"):	
		$Panel.visible = true

func _on_timer_timeout():
	$Panel.visible = false
