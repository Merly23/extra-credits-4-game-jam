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
	timer.start()

func update(host, delta: float):
	up = Input.is_action_pressed("ui_up")
	down = Input.is_action_pressed("ui_down")
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")

	if up or down or left or right:
		host.state_machine.change_state("walk")

func input(host, event: InputEvent):
	if event.is_action_pressed("mouse_left_button"):
		host.state_machine.change_state("attack")

func _on_Timer_timeout() -> void:
	host.state_machine.change_state("walk")
