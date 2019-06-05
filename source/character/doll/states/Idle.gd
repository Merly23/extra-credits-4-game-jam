extends State

var host

var up = false
var down = false
var left = false
var right = false

onready var timer = $Timer

func enter(host):
	self.host = host
	host.set_frame_offset(host.facing, host.ANIMATION.IDLE)
	host.anim.travel("idle")
	host.sprite.frame = 0
	randomize()
	timer.wait_time = rand_range(0.5, 1.2)
	timer.start()

func exit(host):
	timer.stop()

func input(host, event: InputEvent):
	pass

func _on_Timer_timeout() -> void:
	if host.is_target_in_attack_reach():
		host.state_machine.change_state("attack")
	elif host.is_target_in_sight():
		host.state_machine.change_state("walk")
	else:
		timer.start()
