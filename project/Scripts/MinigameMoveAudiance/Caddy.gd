extends Node2D

@export var speed : float = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousedirection = (get_global_mouse_position() - self.position) / 100
	self.position += mousedirection * speed
	pass
