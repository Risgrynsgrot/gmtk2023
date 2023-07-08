extends Node

@export var clubs: Array[Node]

var show_cleaning_supplies: bool
signal selected_club

# Called when the node enters the scene tree for the first time.
func _ready():
	show_cleaning_supplies = false
	for club in clubs:
		club.register_listener(self)
	#connect("selected_club", enable_cleaning_update)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func enable_cleaning_update():
	show_cleaning_supplies = true
	pass
