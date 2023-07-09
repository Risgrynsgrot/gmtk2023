extends Node2D

@export var hover_speed: float = 30.0
var original_position: Vector2
var original_scale: Vector2
var minigame: Node

var follow_mouse: bool

var target_position: Vector2
var target_scale: Vector2

var movement: Vector2

func _ready():
	follow_mouse = false
	original_position = self.position
	original_scale = self.scale
	pass

func _process(delta):
	if follow_mouse == false:
		return
	var last_position = self.position
	move_towards(get_viewport().get_mouse_position(), delta)
	var diff = self.position - last_position
	movement.x += abs(diff.x)
	movement.y += abs(diff.y)
	
	var elasticness = 100.0
	movement.x -= movement.x * delta * elasticness
	movement.y -= movement.y * delta * elasticness
	if (movement.x < 0.0):
		movement.x = 0.0
	if (movement.y < 0.0):
		movement.y = 0.0
	
	target_scale = original_scale + movement * 0.05
	scale_towards(target_scale, delta)
	pass

func register_listener(emitter: Node):
	minigame = emitter
	minigame.connect("selected_club", start_following_mouse)
	pass

func move_towards(target: Vector2, delta):
	var diff = target - self.position
	self.position += diff * delta * hover_speed
	pass
	
func scale_towards(target: Vector2, delta):
	var diff = target - self.scale
	self.scale += diff * delta * hover_speed
	pass

func start_following_mouse():
	follow_mouse = true
	pass
