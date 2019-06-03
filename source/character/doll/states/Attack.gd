extends State

func enter(host):
	var facing = get_facing(host.get_direction(host.global_position, host._target.global_position), host.facing)
	host.set_frame_offset(facing, host.ANIMATION.ATTACK)

	host.anim.travel("attack")

	yield(get_tree().create_timer(0.8), "timeout")

	if host.is_target_in_reach():
		host.state_machine.change_state("attack")
	else:
		host.state_machine.change_state("walk")

func get_facing(direction: Vector2, prev_facing):
	match direction:
		Vector2.UP: return Character.FACING.UP
		Vector2.DOWN: return Character.FACING.DOWN
		Vector2.LEFT: return Character.FACING.LEFT
		Vector2.RIGHT: return Character.FACING.RIGHT
	return prev_facing