extends Node

signal on_minigame_finished(values: MinigameValues, finished_text: String)
signal on_minigame_started(time_limit: float)
signal on_time_out()

@export var minigames: Array[PackedScene]

@onready var game_timer: Timer = $GameTimer
@onready var post_game_delay: Timer = $PostMiniGameDelay
@onready var time_left_text: Label = %TimeLeftText
@onready var time_left_progress_bar: ProgressBar = %TimeLeftProgressBar
@onready var timeout_label: RichTextLabel = %WinLabel
@onready var viewport = %MinigameViewport
@onready var minigame_view = %MinigameView

var is_active = false

var current_time_limit: float
var current_minigame_index: int
var current_minigame_scene: Node

func _ready():
	on_minigame_finished.connect(_on_minigame_finished)
	on_minigame_started.connect(_on_minigame_started)
	#start_new_minigame()

func start_new_minigame():
	print("starting minigame")
	current_minigame_index = randi() % minigames.size()
	current_minigame_scene = minigames[current_minigame_index].instantiate()
	viewport.add_child(current_minigame_scene)
	minigame_view.show()

func _process(_delta):
	#time_left_text.text = "Time left: " + str(game_timer.time_left)
	if is_active:
		time_left_progress_bar.value = game_timer.time_left

func _on_minigame_finished(values: MinigameValues, finished_text: String, won: bool):
#instead of connecting here we connect for example the player, so they get the
#values after you finish the minigame
#use MinigameManager.on_minigame_finished.connect(YOURFUNCTION)
#this will work anywhere because I added it to autoload
	print("wind: " + str(values.wind))
	print("confidence: " + str(values.confidence))
	if won:
		timeout_label.text = "[wave amp=50.0 freq=5.0 connected=1][center]" + finished_text + "[/center][/wave]"
	else:
		timeout_label.text = "[wave amp=50.0 freq=5.0 connected=1][center]" + finished_text + "[/center][/wave]"
	timeout_label.text = "[shake rate=40.0 level=10 connected=1][center]" + finished_text + "[/center][/shake]"
	timeout_label.show()
	post_game_delay.start()
	is_active = false

func _on_minigame_started(time_limit: float):
	current_time_limit = time_limit
	game_timer.wait_time = time_limit
	game_timer.start()
	time_left_progress_bar.min_value = 0
	time_left_progress_bar.max_value = current_time_limit
	time_left_progress_bar.show()
	is_active = true

func _on_game_timer_timeout():
	on_time_out.emit()
	
func _on_post_mini_game_delay_timeout():
	if current_minigame_scene:
		current_minigame_scene.queue_free()
		
	timeout_label.hide()
	minigame_view.hide()
	time_left_progress_bar.hide()


