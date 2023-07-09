extends Node2D

signal car_finished(won: bool)

@export var time_limit: float
var is_active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	MinigameManager.on_minigame_started.emit(time_limit)
	MinigameManager.on_time_out.connect(_on_time_out)
	car_finished.connect(_on_car_finished)

func _on_time_out():
	is_active = false
	var values = MinigameValues.new()
	MinigameManager.on_minigame_finished.emit(values, "You didn't even drive bro!", false)

func _on_car_finished(won: bool):
	is_active = false
	var values = MinigameValues.new()
	if won:
		MinigameManager.on_minigame_finished.emit(values, "You are an epic driver!", true)
		return

	MinigameManager.on_minigame_finished.emit(values, "Do you even have a licence?", false)



func _on_crash_zone_body_entered(body:Node2D):
	var values = MinigameValues.new()
	if !body.is_in_group("Car"):
		return
	MinigameManager.on_minigame_finished.emit(values, "Killing people is cringe!", false)

