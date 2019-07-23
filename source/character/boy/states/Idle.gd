extends State

func enter(host: Boy) -> void:
	host.play_anim("idle")

func input(host: Boy, event: InputEvent) -> void:
	pass

func update(host: Boy, delta: float) -> void:

	if host.get_input_direction():
		host.change_state("walk")

func exit(host: Boy) -> void:
	pass