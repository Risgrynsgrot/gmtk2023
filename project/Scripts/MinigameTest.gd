extends Node2D

func _ready():
	var values = MinigameValues.new()
	values.wind = 10
	values.confidence = 20
	MinigameManager.on_minigame_finished.emit(values)
