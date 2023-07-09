extends Node2D

signal on_map_change(index: int)
signal on_change_club(value: float)
@export var maps: Array[PackedScene]

var ball: Node2D
var minigame_values: MinigameValues
var club_value : float
var current_map_index: int = -1
var map_changed: bool = false

func _ready():
	minigame_values = MinigameValues.new()
	on_map_change.connect(_on_map_change)
	on_map_change.emit(0)
	MinigameManager.on_minigame_finished.connect(_on_minigame_finished)
	MinigameManager.on_club_minigame_finished.connect(_on_club_minigame_finished)
	MinigameManager.post_game_delay.timeout.connect(_on_minigame_closed)

func _process(_delta):
	if map_changed:
		handle_map_changed()
		map_changed = false

func handle_map_changed():
	var current_scene = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	ball = current_scene.get_node("Ball")
	ball.landed.connect(_on_ball_landed)
	$StartGameTimerDelay.start()
	
func _swing_club_at_ball():
	ball.do_swing()

func _on_map_change(index: int):
	var result = get_tree().change_scene_to_file(maps[index].resource_path)
	if result != OK:
		print("map loading failed")
	print("Switched map to " + maps[index].resource_path)
	if current_map_index != index:
		current_map_index = index
		map_changed = true

func _choose_club():
	MinigameManager.start_club_minigame()

func _on_club_minigame_finished(club_minigame_value: float, _finished_text: String):
	club_value = club_minigame_value
	ball.current_distance = club_value
	ball.do_swing()

func _on_minigame_finished(values: MinigameValues, _finished_text: String, _won: bool):
	minigame_values.wind += values.wind
	minigame_values.confidence += values.confidence

func _on_minigame_closed():
	$AfterMinigameDelay.start()

func _on_ball_landed():
	print("landed event")
	MinigameManager.start_new_minigame()

func _on_start_game_timer_delay_timeout():
# this should instead be choose club which then should trigger the swing club function
	_swing_club_at_ball()
	$StartGameTimerDelay.stop()

func _on_after_minigame_delay_timeout():
	_choose_club()
	$AfterMinigameDelay.stop()
