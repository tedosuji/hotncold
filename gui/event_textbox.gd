extends Control


@onready var label : Label = $Panel/Label

var d_active = false

func _ready():
	$Panel.visible = false
	#SignalBus.connect("on_health_changed", on_signal_health_changed)
	SignalBus.connect("on_digbox_entered", digbox_signaled)
	SignalBus.connect("on_sniffbox_entered", sniffbox_signaled)

func start():
	if d_active:
		return
	d_active = true
		
func on_signal_health_changed(node: Node, amount_changed: int):
	
	
	#breakpoint
	if amount_changed == absi(5):
		#breakpoint
		label.text = "Found it!"
			
func digbox_signaled(node: Node, visible: int):
	if absi(visible) == 3:	
		label.text = "Found it!"

func sniffbox_signaled(node: Node, visible: int):			
	if absi(visible) == 4 :
		label.text = "It's close."	

		
func _input(event):
	if Input.is_action_pressed("action"):	
		$Panel.visible = true

func _on_timer_timeout():
	$Panel.visible = false
