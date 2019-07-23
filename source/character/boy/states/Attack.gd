extends State

var host

func enter(host):
	self.host = host
	host.set_frame_offset(host.facing, host.ANIMATION.ATTACK)
	host.anim.travel("attack")
	host.sprite.frame = 0

func attack_finished() -> void:
	host.change_state("Idle")
