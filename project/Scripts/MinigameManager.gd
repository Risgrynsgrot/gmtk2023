extends Node

signal on_minigame_finished(values: MinigameValues, finished_text: String)
signal on_minigame_started(time_limit: float)
signal on_time_out()

@export var minigames: Array[PackedScene]

@onready var game_timer: Timer = $GameTimer
@onready var post_game_delay: Timer = $PostMiniGameDelay
@onready var time_left_text: Label = %TimeLeftText
@onready var time_left_progress_bar: ProgressBar = %TimeLeftProgressBar
@onready var timeout_label: Label = %WinLabel

var current_time_limit: float
var current_minigame_index: int
var current_minigame_scene: Node

func _ready():
	on_minigame_finished.connect(_on_minigame_finished)
	on_minigame_started.connect(_on_minigame_started)
	start_new_minigame()

func start_new_minigame():
	current_minigame_index = randi() % minigames.size()
	current_minigame_scene = minigames[current_minigame_index].instantiate()
	add_child(current_minigame_scene)

func _process(_delta):
	#time_left_text.text = "Time left: " + str(game_timer.time_left)
	time_left_progress_bar.value = game_timer.time_left


func _on_minigame_finished(values: MinigameValues, finished_text: String):
#instead of connecting here we connect for example the player, so they get the
#values after you finish the minigame
#use MinigameManager.on_minigame_finished.connect(YOURFUNCTION)
#this will work anywhere because I added it to autoload
	print("wind: " + str(values.wind))
	print("confidence: " + str(values.confidence))
	timeout_label.text = finished_text
	timeout_label.show()
	post_game_delay.start()

func _on_minigame_started(time_limit: float):
	current_time_limit = time_limit
	game_timer.wait_time = time_limit
	game_timer.start()
	time_left_progress_bar.min_value = 0
	time_left_progress_bar.max_value = current_time_limit

func _on_game_timer_timeout():
	on_time_out.emit()
	
func _on_post_mini_game_delay_timeout():
	current_minigame_scene.queue_free()
	timeout_label.hide()


