extends Node2D

@export var club_distance : float
@export var hover_speed: float = 10.0
@export var dirt: Array[Node2D]
var original_position: Vector2
var original_scale: Vector2
var hovered: bool
var selected: bool
var minigame: Node

var target_position: Vector2
var target_scale: Vector2

var dirt_cleaned_count: int

@onready var collider: CollisionShape2D = $Area2D/CollisionShape2D

signal clean

# Called when the node enters the scene tree for the first time.
func _ready():
	original_position = self.position
	original_scale = self.scale
	target_position = original_position
	target_scale = original_scale
	selected = false
	dirt_cleaned_count = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_towards(target_position, delta)
	scale_towards(target_scale, delta)
	if Input.is_action_just_pressed("left_click") && hovered:
		select_club()
	#var mouse_pos = get_viewport().get_mouse_position()
	#print(collided)
	#if !collided:
	#	return
	#if collided.get_parent() == self:
	#	if selected:
	#		return
	#	target_position = original_position + Vector2(0.0, -200.0)
	#	target_scale = original_scale * Vector2(1.1, 1.1)
	#	pass # Replace with function body.

	#if collided.get_parent() != self:
	#	if selected:
	#		return
	#	target_position = original_position
	#	target_scale = original_scale
	#	hovered = false

func move_towards(target: Vector2, delta):
	var diff = target - self.position
	self.position += diff * delta * hover_speed
	pass

func scale_towards(target: Vector2, delta):
	var diff = target - self.scale
	self.scale += diff * delta * hover_speed
	pass

func _on_area_2d_mouse_entered():
	pass
func _on_area_2d_mouse_exited():
	pass # Replace with function body.

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			select_club()
	pass

func hide_club():
	if selected == false:
		var offset = Vector2(0.0, MinigameManager.viewport.get_visible_rect().size.y * 0.5)
		target_position = original_position + offset
	pass

func select_club():
	selected = true
	minigame.emit_signal("selected_club")
	var offset = Vector2(0.0, MinigameManager.viewport.get_visible_rect().size.y * 0.8)
	target_position = MinigameManager.viewport.get_visible_rect().get_center() + offset
	target_scale = original_scale * Vector2(3.5, 3.5)
	if !clean.is_connected(cleaned_dirt):
		clean.connect(cleaned_dirt)
	for dirt_spot in dirt:
		dirt_spot.cleaning_locked = false
		dirt_spot.golf_club = self
	pass

func register_listener(emitter: Node):
	minigame = emitter
	minigame.connect("selected_club", hide_club)
	pass

func cleaned_dirt():
	dirt_cleaned_count += 1
	if (dirt_cleaned_count >= dirt.size()):
		MinigameManager.on_club_minigame_finished.emit(club_distance, "Just like new!")
	pass


func _on_area_2d_area_entered(area):
	if !area.is_in_group("MouseCollider"):
		return
	if selected:
		return
	var offset = Vector2(0.0, MinigameManager.viewport.get_visible_rect().size.y * -0.3)
	target_position = original_position + offset
	target_scale = original_scale * Vector2(1.1, 1.1)
	hovered = true
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	if !area.is_in_group("MouseCollider"):
		return
	if selected:
		return
	target_position = original_position
	target_scale = original_scale
	hovered = false
