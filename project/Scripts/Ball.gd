extends Node2D
@export var hole : Node
@export var ball_max_fly_time : float
@export var max_distance : float = 50
@export var current_distance : float = 20

var swing_position : Vector2
var landing_position : Vector2
var current_fly_time : float = 0
var has_swung : bool = false
var is_flying : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = hole.start_marker.position
	swing_position = self.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		has_swung = true
	
	if has_swung:
		landing_position = swing_position + _swing(current_distance)
		has_swung = false
		is_flying = true
		
	if is_flying:
		current_fly_time += delta
		var lerp_value = clamp(current_fly_time / ball_max_fly_time,0,1)
		self.position = lerp(swing_position,landing_position,clamp(current_fly_time,0,1))
		if lerp_value >= 1:
			is_flying = false
			swing_position = self.position
		
	
func _swing(current_distance:float):
	var aim_position:Vector2 = hole._get_furthest_in_reach_aim_pos(self.position,max_distance)
	var aim_direction:Vector2 = (aim_position - self.position).normalized()
	return aim_direction * current_distance;
