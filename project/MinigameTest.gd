extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var values = MinigameValues.new()
	values.wind = 10
	values.confidence = 20
	MinigameManager.on_minigame_finished.emit(values)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
