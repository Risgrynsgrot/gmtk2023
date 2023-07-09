extends Node2D

signal on_clapped


@export var progress_bar: ProgressBar
@export var time_limit: float

var clap_score: int
var is_active: bool = true

func _ready():
	on_clapped.connect(_on_clapped)
	MinigameManager.on_minigame_started.emit(time_limit)
	MinigameManager.on_time_out.connect(_on_time_out)

func _process(_delta):
	pass

func _on_clapped():
	if !is_active:
		return
	clap_score += 1
	progress_bar.value = clap_score

func _on_time_out():
	is_active = false
	var values = MinigameValues.new()
	MinigameManager.on_minigame_finished.emit(values, "Clappers!", true)
