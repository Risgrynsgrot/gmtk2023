extends Node2D

signal landed

@export var hole : Node
@export var ball_max_fly_time : float
@export var max_distance : float = 50
@export var current_distance : float = 20
@export var max_scale_change : float = 1.5
@export var time_to_lerp_distance_curve : Curve
@export var time_to_scale_deformation_curve : Curve
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
	if has_swung:
		print("swung")
		landing_position = swing_position + _swing(current_distance)
		has_swung = false
		is_flying = true
		
	if is_flying:
		current_fly_time += delta
		var lerp_value =  clamp(current_fly_time / ball_max_fly_time,0,1)
		var curve_distance = time_to_lerp_distance_curve.sample(lerp_value)
		self.position = lerp(swing_position,landing_position,curve_distance)
		var scale_deformation = time_to_scale_deformation_curve.sample(curve_distance)
		self.scale = Vector2( 1+scale_deformation, 1+scale_deformation);
		if lerp_value > 0.95:
			print("landed")
			is_flying = false
			swing_position = self.position
			self.scale = Vector2(1,1)
			current_fly_time = 0
			landed.emit()
		
	
func _swing(current_distance:float):
	var aim_position:Vector2 = hole._get_furthest_in_reach_aim_pos(self.position,max_distance)
	var aim_direction:Vector2 = (aim_position - self.position).normalized()
	return aim_direction * current_distance;

func do_swing():
	if !is_flying:
		print("swinging")
		has_swung = true
		$AudioStreamPlayer.play()
