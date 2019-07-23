extends State

var host

func enter(host):
	self.host = host
	var facing = get_facing(host.get_direction(host.global_position, host._target.global_position), host.facing)
	host.set_frame_offset(facing, host.ANIMATION.ATTACK)
	host.anim.travel("attack")
	host.sprite.frame = 0

func get_facing(direction: Vector2, prev_facing):
	match direction:
		Vector2.UP: return Character.FACING.UP
		Vector2.DOWN: return Character.FACING.DOWN
		Vector2.LEFT: return Character.FACING.LEFT
		Vector2.RIGHT: return Character.FACING.RIGHT
	return prev_facing

func attack_finished():
		host.change_state("Idle")