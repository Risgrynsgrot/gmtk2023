extends Node

@export var clubs: Array[Node2D]
@export var cleaning_cloth: Node2D

var show_cleaning_supplies: bool
signal selected_club

# Called when the node enters the scene tree for the first time.
func _ready():
	show_cleaning_supplies = false
	for club in clubs:
		club.register_listener(self)
	cleaning_cloth.register_listener(self)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta
	pass
	
func enable_cleaning_update():
	show_cleaning_supplies = true
	pass
