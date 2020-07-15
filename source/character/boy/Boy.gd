extends Character
class_name Boy

func _ready() -> void:
	Global.Boy = self
	change_state("idle")

func hit() -> void:
	print("hit")

func attack_finished() -> void:
	change_state("idle")

func play_sfx(sfx_name: String) -> void:
	Audio.play_booth_sfx(sfx_name)
