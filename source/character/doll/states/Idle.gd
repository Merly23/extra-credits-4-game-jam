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
	randomize()
	timer.wait_time = rand_range(1.0, 2.0)
	timer.start()

func exit(host):
	timer.stop()

func update(host, delta: float):
	if host.is_target_in_reach():
		host.state_machine.change_state("attack")

func input(host, event: InputEvent):
	pass

func _on_Timer_timeout() -> void:
	host.state_machine.change_state("walk")
