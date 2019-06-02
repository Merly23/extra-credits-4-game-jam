extends State

func enter(host):
	host.set_frame_offset(host.facing, host.ANIMATION.ATTACK)
	host.anim.travel("attack")

	yield(get_tree().create_timer(0.3), "timeout")

	host.state_machine.change_state("idle")
