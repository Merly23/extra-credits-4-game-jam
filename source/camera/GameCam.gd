extends Camera2D
class_name GameCam

var targets := [] setget _set_targets

onready var tween := $Tween as Tween

onready var state_machine := $StateMachine as StateMachine

func _ready() -> void:
	state_machine.host = self
	state_machine.register_state("single", "Single")
	state_machine.register_state("double", "Double")
	state_machine.change_state("single")

func get_target_position() -> Vector2:
	var new_position := Vector2()

	for target in targets:
		new_position += target.global_position

	return new_position / targets.size()

func characters_in_reach() -> bool:
	return (Global.Girl.global_position - Global.Boy.global_position).length() < 185

func _set_targets(value) -> void:
	targets = value

func _on_Boy_ready() -> void:
	targets = [ Global.Boy ]
