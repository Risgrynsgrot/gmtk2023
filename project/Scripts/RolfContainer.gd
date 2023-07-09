extends Control

@export var rolf_happy: Control
@export var rolf_neutral: Control
@export var rolf_bummed: Control
@export var rolf_angry: Control

enum rolf_faces
{
	HAPPY,
	NEUTRAL,
	BUMMED,
	ANGRY
}
@onready var faces = {
	rolf_faces.HAPPY: rolf_happy,
	rolf_faces.NEUTRAL: rolf_neutral,
	rolf_faces.BUMMED: rolf_bummed,
	rolf_faces.ANGRY: rolf_angry,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_all()
	pass # Replace with function body.

func hide_all():
	rolf_happy.hide()
	rolf_neutral.hide()
	rolf_bummed.hide()
	rolf_angry.hide()
	pass

func show_face(face: rolf_faces):
	hide_all()
	faces[face].show()
	show_window()

func show_window():
	%RolfPanel.show()
	%RolfPanel/AnimationPlayer.play("Show_panel")


func _on_show_timer_timeout():
	%RolfPanel/AnimationPlayer.play("Hide_Panel")

func _on_animation_player_animation_finished(anim_name:StringName):
	if anim_name == "Show_panel":
		%ShowTimer.start()
		return

	if anim_name == "Hide_Panel":
		%RolfPanel.hide()

