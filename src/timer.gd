extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Reset_StartTimer()
	pass # Replace with function body.

var seconds = 0
var minutes = 0
var Dseconds = 30
var Dminutes = 1

func _on_start_timer_timeout():
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
	seconds -= 1		

	#$Lable.get(minutes)+":"+(seconds)
	$Label.text = String(minutes) + ":" + String(seconds)
	pass

func Reset_StartTimer():
	seconds = Dseconds
	minutes = Dminutes	


