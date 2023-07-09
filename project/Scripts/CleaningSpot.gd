extends Node2D

@export var collisions_until_clean: int = 4
@export var collisions_until_polished: int = 4
@export var dirt_sprite: Sprite2D = null
@export var sparkle_sprite: Sprite2D = null

var original_dirt_scale: Vector2
var original_sparkle_scale: Vector2

var start_clean_count: int = 0
var start_polished_count: int = 0

var cleaning_locked: bool

var target_dirt_scale: Vector2

var sparkle_timer: float

var golf_club: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	start_clean_count = collisions_until_clean
	start_polished_count = collisions_until_polished
	cleaning_locked = true
	original_dirt_scale = dirt_sprite.scale
	target_dirt_scale = original_dirt_scale
	
	original_sparkle_scale = sparkle_sprite.scale
	
	sparkle_timer = 0.0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var diff = target_dirt_scale - dirt_sprite.scale;
	dirt_sprite.scale += diff * delta * 10.0
	
	if (collisions_until_polished <= 0):
		sparkle_timer += delta
		sparkle_sprite.scale = original_sparkle_scale * (sin(sparkle_timer * 10.0) + 1.0) * 0.5
	pass

func _on_area_2d_mouse_entered():
	if (cleaning_locked):
		return
	
	if (collisions_until_clean > 0):
		collisions_until_clean -= 1
		if (collisions_until_clean <= 0):
			dirt_sprite.hide() #TODO change for scale down and hide
	elif (collisions_until_polished > 0):
		collisions_until_polished -= 1
		if (collisions_until_polished <= 0):
			sparkle_sprite.show()
			golf_club.emit_signal("clean")
	
	var clean_scale = float(collisions_until_clean)/float(start_clean_count)
	target_dirt_scale = original_dirt_scale * clean_scale
	pass
