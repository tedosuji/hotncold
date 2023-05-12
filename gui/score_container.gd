extends Control

@onready var scoreLabel: Label = $score

var score: int = 0

func _ready():
	SignalBus.connect("on_score_increment", _on_score_increment)

func _on_score_increment(amount: int):
	score += amount
	scoreLabel.text = str(score)
