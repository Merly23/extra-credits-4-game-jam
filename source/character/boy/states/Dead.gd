extends State

func enter(host):
	host.health_bar.hide()
	host.set_frame_offset(host.FACING.DOWN, host.ANIMATION.DIE)
	host.anim.travel("die")

	yield(get_tree().create_timer(0.5), "timeout")

	Scene.change(Scene.GameOver)