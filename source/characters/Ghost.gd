extends KinematicBody2D

onready var tween := $Tween as Tween

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left_button"):
		tween.interpolate_property(self, "global_position", global_position, get_global_mouse_position(), 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.start()