extends State

func enter(host):
	host.anim.travel("die")
	host.set_frame_offset(host.facing, host.ANIMATION.DIE)

	yield(get_tree().create_timer(1.1), "timeout")

	host.queue_free()