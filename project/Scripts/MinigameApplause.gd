extends Node2D

signal on_clapped

@export var progress_bar: ProgressBar
var clap_score: int

# Called when the node enters the scene tree for the first time.
func _ready():
	on_clapped.connect(_on_clapped)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_clapped():
	clap_score += 1
	progress_bar.value = clap_score
