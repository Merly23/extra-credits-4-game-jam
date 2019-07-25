extends Camera2D
class_name GameCam

var targets := [] setget _set_targets

onready var tween := $Tween as Tween

onready var fsm := $FiniteStateMachine as FiniteStateMachine

func _ready() -> void:
	fsm.host = self
	fsm.change_state("single")

func get_target_position() -> Vector2:
	var new_position := Vector2()

	for target in targets:
		new_position += target.global_position

	return new_position / targets.size()

func change_state(state_name: String) -> void:
	fsm.change_state(state_name)

func characters_in_reach() -> bool:
	if Global.Boy and Global.Girl:
		var dist_vec = Global.Girl.global_position - Global.Boy.global_position
		dist_vec.x *= 0.5
		return dist_vec.length() < 140
	return false

func _set_targets(value) -> void:
	targets = value

func _on_Boy_ready() -> void:
	targets = [ Global.Boy ]
