extends KinematicBody2D
class_name Character

signal health_changed(new_heath)
signal died()

var health := 0

var motion := Vector2(0, 0)

export var health_max := 20

onready var anim_player := $AnimationPlayer as AnimationPlayer
onready var tween := $Tween as Tween

onready var sprite := $Sprite as Sprite

onready var fsm = $FiniteStateMachine as FiniteStateMachine

func _ready() -> void:
	health = health_max
	fsm.host = self

func _physics_process(delta: float) -> void:
	move_and_slide(motion)

func get_input_direction() -> Vector2:

	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")

	return Vector2(int(right) - int(left), int(up) - int(down))

func harm(origin, damage: int) -> void:
	_set_health(health - damage)

	tween.interpolate_property(sprite, "modulate", Color("FF0000"), Color("FFFFFF"), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

	knockback(origin)

func heal(value: int) -> void:
	_set_health(health + value)

	tween.interpolate_property(sprite, "modulate", Color("00FF00"), Color("FFFFFF"), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

func knockback(origin: Vector2, force := 200):
	var direction = origin.direction_to(global_position)

	tween.interpolate_property(self, "motion", direction * force, Vector2(0, 0), 0.25, Tween.TRANS_QUAD, Tween.EASE_OUT)
	tween.start()

func change_state(state_name: String) -> void:
	fsm.change_state(state_name)

func is_fully_healed():
	return health == health_max

func _set_health(new_health):
	health = clamp(new_health, 0, health_max)

	emit_signal("health_changed")

	if health == 0:
		emit_signal("died")

func _on_FiniteStateMachine_state_changed(state_name) -> void:
	print("%s: %s" % [name, state_name])
