extends Node
class_name FiniteStateMachine

signal state_changed(state_name)

var states := {}

var current_state = null

var host = null

func _ready() -> void:

	for state in get_children():
		states[state.name] = state

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.input(host, event)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.update(host, delta)

func change_state(new_state: String) -> void:

	print("%s: %s" % [host.name, new_state])
	if current_state:
		current_state.exit(host)

	current_state = states[new_state]

	current_state.enter(host)

	emit_signal("state_changed", current_state.name)

func is_current_state(state_name) -> bool:

	if not current_state:
		return false

	return current_state.name == state_name