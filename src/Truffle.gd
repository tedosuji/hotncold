extends CharacterBody2D

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Truffle")
	GameSettings.debug_mode_changed.connect(_on_debug_mode_changed)
	# Set initial visibility based on debug mode
	if sprite:
		sprite.visible = GameSettings.debug_mode

func _on_debug_mode_changed(enabled: bool):
	if sprite:
		sprite.visible = enabled



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

