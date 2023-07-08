extends Node2D
@export var some_aim_markers : Array[Marker2D]
@export var start_marker : Marker2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _get_furthest_in_reach_aim_pos(pos:Vector2, max_distance:float):
	var return_value:Vector2 = some_aim_markers[0].position;
	for markers in some_aim_markers:
		if markers.position.distance_squared_to(pos) > max_distance*max_distance:
			return return_value
		else:
			return_value = markers.position
