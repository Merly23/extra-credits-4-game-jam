extends Node
class_name StateMachine

signal state_changed(state_name)

var host = null

var current_state : State = null

onready var states := {}

func _unhandled_input(event: InputEvent) -> void:
	current_state.input(host, event)

func _physics_process(delta: float) -> void:
	current_state.update(host, delta)

func register_state(id: String, node_path: String):
	states[id] = get_node(node_path)

func change_state(new_state):

	if current_state:
		current_state.exit(host)

	current_state = states[new_state]
	current_state.enter(host)

	emit_signal("state_changed", current_state.name)