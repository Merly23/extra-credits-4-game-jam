extends Camera2D
class_name GameCam

onready var tween := $Tween as Tween

func update_position(boy_position: Vector2, girl_position: Vector2) -> void:
	var new_position := Vector2()

	if (girl_position - boy_position).length() > 185:
		new_position = boy_position
	else:
		new_position = (boy_position + girl_position) / 2
		new_position = Vector2(floor(new_position.x), floor(new_position.y))

	tween.interpolate_property(self, "global_position", global_position, new_position, 0.06, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()