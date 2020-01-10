extends State

func enter(host: Doll) -> void:
	host.play_anim("idle")

func input(host: Doll, event: InputEvent) -> void:
	pass

func update(host: Doll, delta: float) -> void:

	if host.target:
		host.change_state("walk")

func exit(host: Doll) -> void:
	pass
