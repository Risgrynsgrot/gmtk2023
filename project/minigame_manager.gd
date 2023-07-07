extends Node

signal on_minigame_finished(values: MinigameValues)
#signal on_minigame_finished()

func _ready():
	on_minigame_finished.connect(_on_minigame_finished)

func _process(_delta):
	pass

func _on_minigame_finished(values: MinigameValues):
#instead of connecting here we connect for example the player, so they get the
#values after you finish the minigame
#use MinigameManager.on_minigame_finished.connect(YOURFUNCTION)
#this will work anywhere because I added it to autoload
	print("wind: " + str(values.wind))
	print("confidence: " + str(values.confidence))
