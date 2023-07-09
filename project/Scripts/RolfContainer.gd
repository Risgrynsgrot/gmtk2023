extends Node2D

@export var rolf_happy: Node2D
@export var rolf_neutral: Node2D
@export var rolf_bummed: Node2D
@export var rolf_angry: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_all()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func hide_all():
	rolf_happy.hide()
	rolf_neutral.hide()
	rolf_bummed.hide()
	rolf_angry.hide()
	pass
