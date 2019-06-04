extends State

var host

func enter(host):
	self.host = host
	host.set_frame_offset(host.facing, host.ANIMATION.ATTACK)
	host.anim.travel("attack")

func attack_finished() -> void:
	host.state_machine.change_state("idle")
