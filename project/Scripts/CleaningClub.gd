extends Node2D

@export var hover_speed: float = 10.0
var original_position: Vector2
var original_scale: Vector2
var hovered: bool
var selected: bool
var minigame: Node

var target_position: Vector2
var target_scale: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	original_position = self.position
	original_scale = self.scale
	target_position = original_position
	target_scale = original_scale
	selected = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_towards(target_position, delta)
	scale_towards(target_scale, delta)
	pass

func move_towards(position: Vector2, delta):
	var diff = position - self.position
	self.position += diff * delta * hover_speed
	pass
	
func scale_towards(scale: Vector2, delta):
	var diff = scale - self.scale
	self.scale += diff * delta * hover_speed
	pass

func _on_area_2d_mouse_entered():
	if selected:
		return
	target_position = original_position + Vector2(0.0, -200.0)
	target_scale = original_scale * Vector2(1.1, 1.1)
	pass # Replace with function body.

func _on_area_2d_mouse_exited():
	if selected:
		return
	target_position = original_position
	target_scale = original_scale
	hovered = false
	pass # Replace with function body.


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			selected = true
			print("selecting")
			minigame.emit_signal("selected_club")
			target_position = get_viewport_rect().get_center() + Vector2(0.0, 300)
	pass
	
func hide_club():
	print("called hide")
	if selected == false:
		print("hiding!!")
		target_position = original_position + Vector2(0.0, 500.0)
	pass
	
func register_listener(emitter: Node):
	minigame = emitter
	minigame.connect("selected_club", hide_club)
	pass
