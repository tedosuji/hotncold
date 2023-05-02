extends Node

class_name damageable

@export var health : float = 1

func hit(damage: int):
	health -= damage
	
	if(health <= 0):
		get_parent().queue_free()
		
