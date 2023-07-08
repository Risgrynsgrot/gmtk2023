extends Node2D

@export var rotation_range: Vector2
@export var min_offset_range: Vector2
@export var offset_range: Vector2

func _ready():
	rotation_degrees = randf_range(rotation_range.x, rotation_range.y)
	var position_change: Vector2 = Vector2.ZERO
	position_change.x += randf_range(min_offset_range.x, offset_range.x)
	position_change.y += randf_range(-min_offset_range.y, -offset_range.y)
	if randi() % 2 == 0:
		position_change.x *= -1
	position += position_change


func _on_lifetime_timeout():
	queue_free()

