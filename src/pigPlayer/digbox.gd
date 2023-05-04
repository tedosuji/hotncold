extends Area2D

@export var damage : int = 5
@onready var sniffbox : Area2D = $sniffbox


func _ready():
	monitoring = false

func _on_body_entered(body):
	#sniffbox.visible
	
	for child in body.get_children():
		if child is damageable:
			child.hit(damage)
			print_debug(body.name + " took " + str(damage) + "damage.")
			
