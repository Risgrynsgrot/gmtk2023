extends Node2D

@export var right_hand: Node2D

@export var minigame: Node

@export var clap_particle: PackedScene

var move_speed: Vector2
var rotation_speed: float

var is_active = true
var last_position: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_viewport_rect().get_center()
	position.x -= get_viewport_rect().size.x / 6

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	right_hand.global_position = get_global_mouse_position()
	if last_position != right_hand.position:
		right_hand.rotation = (last_position - right_hand.position).angle()
	last_position = right_hand.position



func _on_left_hand_collider_area_entered(area:Area2D):
	if area.is_in_group("Hand"):
		minigame.emit_signal("on_clapped")
		var clap = clap_particle.instantiate()
		clap.global_position = global_position
		add_sibling(clap)


