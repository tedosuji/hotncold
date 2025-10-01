extends Control

@onready var scoreLabel: Label = $score

var truffles_remaining: int = 10

func _ready():
	print("Score container ready, connecting signal")
	SignalBus.connect("on_truffles_remaining", _on_truffles_remaining)
	# Set initial display
	scoreLabel.text = str(truffles_remaining)
	print("Initial counter set to: ", truffles_remaining)

func _on_truffles_remaining(remaining: int):
	truffles_remaining = remaining
	scoreLabel.text = str(truffles_remaining)
	print("Truffles remaining updated to: ", truffles_remaining)
