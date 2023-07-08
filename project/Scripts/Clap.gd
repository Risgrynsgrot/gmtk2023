extends Node2D

@export var speed_range: Vector2
@export var rotation_speed_range: Vector2
@export var gravity: Vector2

var speed: Vector2
var rotation_speed: float

func _ready():
	speed.x = randf_range(speed_range.x, speed_range.y)
	speed.y = randf_range(speed_range.x, speed_range.y)

	rotation_speed = randf_range(rotation_speed_range.x, rotation_speed_range.y)

func _process(delta):
	speed += gravity * delta
	position += speed * delta


func _on_lifetime_timeout():
	queue_free()

