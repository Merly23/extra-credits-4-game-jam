extends State

var tween_time := 0.14

func enter(host):
	if Global.Boy:
		host.targets = [ Global.Boy ]
	else:
		tween_time = -1

func exit(host):
	host.tween.stop_all()
	tween_time = 0.14

func update(host, delta: float) -> void:
	if host.characters_in_reach():
		host.state_machine.change_state("double")

	if tween_time > 0:
		tween_time -= delta / 10
		host.tween.interpolate_property(host, "global_position", host.global_position, host.get_target_position(), tween_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		host.tween.start()
	else:
		host.global_position = host.get_target_position()
