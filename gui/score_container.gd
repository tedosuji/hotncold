extends Control

@onready var scoreLabel: Label = $score

var score: int = 0
var truffles_remaining: int = 10

func _ready():
	SignalBus.connect("on_score_increment", _on_score_increment)
	SignalBus.connect("on_truffles_remaining", _on_truffles_remaining)

func _on_score_increment(amount: int):
	score += amount
	scoreLabel.text = str(score)

func _on_truffles_remaining(remaining: int):
	truffles_remaining = remaining
	scoreLabel.text = str(truffles_remaining)
