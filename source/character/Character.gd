extends KinematicBody2D
class_name Character

signal died

export var max_health := 5

var health := Attribute.new()

var motion := Vector2()
var facing := Vector2()

onready var fsm := $FSM as FiniteStateMachine
onready var sprite := $Sprite as Sprite
onready var anim := $AnimationPlayer as AnimationPlayer
onready var tween := $Tween as Tween


func _ready() -> void:
	fsm.host = self
	health.init(max_health)


func heal(amount: int) -> void:
	health.value += amount


func hurt(damage: int) -> void:
	health.value -= damage

	if health.is_empty():
		emit_signal("died")


func change_state(state_name: String) -> void:
	fsm.change_state(state_name)


func get_input_direction() -> Vector2:
	return get_raw_input_direction().normalized()


func get_raw_input_direction() -> Vector2:

	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")

	return Vector2(int(right) - int(left), int(down) - int(up))
