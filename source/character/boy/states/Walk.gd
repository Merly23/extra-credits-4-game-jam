extends State

export var speed := 100

func enter(host: Boy) -> void:
	host.play_anim("walk")

func update(host: Boy, delta: float) -> void:
	host.update_animation()

	var input_direction = host.get_input_direction().normalized()

	host.motion = input_direction * speed

	if not input_direction:
		host.change_state("idle")

func exit(host: Boy) -> void:
	host.motion = Vector2(0, 0)