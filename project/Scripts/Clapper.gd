extends Node2D

@export var right_hand: Node2D

@export var minigame: Node

var move_speed: Vector2
var rotation_speed: float

var is_active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	right_hand.position = get_global_mouse_position()
	if Input.is_action_just_pressed("left_click"):
		minigame.emit_signal("on_clapped")

