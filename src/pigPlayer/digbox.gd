extends Area2D

@export var damage : int = 5
@onready var sniffbox : Area2D= $sniffbox
@export var in_digbox : int = 3
@export var out_digbox : int = 5 

func _ready():
	monitoring = false

func _on_body_entered(body):
	for child in body.get_children():
		if child is damageable:
			child.hit(damage)
			print_debug(body.name + " took " + str(damage) + "damage.")
	
	SignalBus.emit_signal("on_digbox_entered", get_parent(), in_digbox)




#func _on_area_exited(area):
	#SignalBus.emit_signal("on_digbox_entered", get_parent(), out_digbox)
