extends Node2D
@export var audiance_members : Array[Node2D]
@export var golf_ball : Node2D
@export var player : Node2D
@export var audiance_ball_speed : float
@export var audiance_avoid_speed : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for audiance_member in audiance_members:
		var player_to_member = audiance_member.position - player.position
		var direction_to_ball = (golf_ball.position - audiance_member.position).normalized() * delta * 100
		var direction_away_from_player = player_to_member.normalized() * delta * max(0,)
		audiance_member.position += direction_away_from_player
	
