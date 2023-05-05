extends Area2D

@export var sniff : int = 4
@onready var sniffboxCollision : CollisionShape2D= $CollisionShape2D



func _ready():
	monitoring = false
	SignalBus.connect("on_digbox_entered", digbox_signaled)
	#SignalBus.connect("on_truffle_exit", truffledeath_signaled)
	
	
func digbox_signaled(node: Node, visible : int):
	
		if visible == absi(3):
			set_collision_mask_value(2, false)

#func truffledeath_signaled(node: Node, visible : int):		
	#if absi(visible) == 2:	
		#set_collision_mask_value(2, true)
	
func _on_body_entered(body):
	for child in body.get_children():
		if child is damageable:
			#child.hit(damage)
			print_debug(body.name + " is close.")
	SignalBus.emit_signal("on_sniffbox_entered", get_parent(), sniff)
	
		#print_debug(" digbox in")

		
