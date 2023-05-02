extends Panel

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active = true

#func updateAnimation():

func _physics_process(delta):
	var state_machine = $AnimationTree.get("parameters/playback")
	
	state_machine.travel("portrait_idle")
	
	if Input.is_action_pressed("action"):
		state_machine.travel("portrait_truffle")


