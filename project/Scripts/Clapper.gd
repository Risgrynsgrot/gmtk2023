extends Node2D

@export var right_hand: Node2D

@export var minigame: Node

@export var clap_particle: PackedScene

var move_speed: Vector2
var rotation_speed: float

var is_active = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	right_hand.global_position = get_global_mouse_position()



func _on_left_hand_collider_area_entered(area:Area2D):
	if area.is_in_group("hand"):
		minigame.emit_signal("on_clapped")


