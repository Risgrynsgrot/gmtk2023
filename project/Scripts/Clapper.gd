extends Node2D

@export var hand_in: Marker2D
@export var hand_out: Marker2D

@export var right_hand: Node2D

@export var minigame: Node

var move_speed: Vector2
var rotation_speed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
		right_hand.position = hand_in.position
		minigame.emit_signal("on_clapped")

	if Input.is_action_just_released("left_click"):
		right_hand.position = hand_out.position
