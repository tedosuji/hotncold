extends Node

# Stores game completion time and high scores
var completion_time: float = 0.0
var high_scores: Array = []

const SAVE_PATH = "user://high_scores.save"
const MAX_HIGH_SCORES = 5

func _ready():
	load_high_scores()

func save_high_scores():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(high_scores)
		file.close()

func load_high_scores():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			high_scores = file.get_var()
			file.close()
	else:
		# Default high scores
		high_scores = []

func add_high_score(player_name: String, time: float):
	high_scores.append({"name": player_name, "time": time})
	# Sort by time (ascending - faster is better)
	high_scores.sort_custom(func(a, b): return a.time < b.time)
	# Keep only top scores
	if high_scores.size() > MAX_HIGH_SCORES:
		high_scores.resize(MAX_HIGH_SCORES)
	save_high_scores()

func is_high_score(time: float) -> bool:
	if high_scores.size() < MAX_HIGH_SCORES:
		return true
	return time < high_scores[MAX_HIGH_SCORES - 1].time

func format_time(time: float) -> String:
	var minutes = int(time / 60)
	var seconds = int(time - (minutes * 60))
	var milliseconds = int((time - int(time)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, milliseconds]
