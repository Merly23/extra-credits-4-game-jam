extends State

func enter(host):
	host.set_frame_offset(host.FACING.DOWN, host.ANIMATION.DIE)
	host.anim.travel("die")

	yield(get_tree().create_timer(1.1), "timeout")

	host.queue_free()