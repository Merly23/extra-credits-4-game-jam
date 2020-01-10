extends Character
class_name Boy

func _unhandled_input(event: InputEvent) -> void:

	if event.is_action_pressed("mouse_left_button"):
		change_state("attack")

func _ready() -> void:
	Global.Boy = self
	change_state("idle")

func hit() -> void:
	print("hit")

func attack_finished() -> void:
	change_state("idle")
