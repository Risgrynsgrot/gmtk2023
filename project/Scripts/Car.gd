extends RigidBody2D

var power: float
@onready var power_bar = %PowerBar
@onready var root_scene = get_parent()

@export var max_power = 100000
@export var power_increase = 200000
@export var reverse_power = 1

func _ready():
	power_bar.max_value = max_power

func _process(delta: float):
	if Input.is_action_pressed("left_click"):
		power += delta * power_increase * reverse_power
		power_bar.set_value_no_signal(power)

	if power > max_power:
		reverse_power = -1
		power = max_power

	if power < 0:
		power = 0
		reverse_power = 1

	if Input.is_action_just_released("left_click"):
		apply_force(Vector2(power, 0))


func _on_finish_line_body_entered(body:Node2D):
	if !body.is_in_group("Car"):
		return
	if rotation_degrees < 80 || rotation_degrees > 100 || position.y < 340:
		root_scene.car_finished.emit(false)
		return

	root_scene.car_finished.emit(true)

