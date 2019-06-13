extends KinematicBody2D
class_name Character

enum FACING { DOWN, RIGHT, UP, LEFT }

var health := 0

var knocked_back := false
var knockback_direction := Vector2()

export(FACING) var facing := FACING.DOWN

export var health_max := 20

export var frame_size := Vector2(16, 16)

onready var anim_player := $AnimationPlayer as AnimationPlayer
onready var anim_tree := $AnimationTree as AnimationTree
onready var anim = anim_tree.get("parameters/playback")
onready var tween := $Tween as Tween

onready var sprite := $Sprite as Sprite

onready var knockback_timer := $KnockbackTimer as Timer

onready var state_machine = $StateMachine as StateMachine

func _ready() -> void:
	anim_tree.advance(0)
	state_machine.host = self
	health = health_max

func get_direction(a: Vector2, b: Vector2) -> Vector2:
	var dir = (b - a).normalized()
	if dir.x < -0.5: dir.x = -1
	elif dir.x > 0.5: dir.x = 1
	else: dir.x = 0
	if dir.y < -0.5: dir.y = -1
	elif dir.y > 0.5: dir.y = 1
	else: dir.y = 0
	return dir

func _on_StateMachine_state_changed(state_name) -> void:
	print(self, ": ", state_name)

func harm(origin, damage: int) -> void:
	health -= damage
	tween.interpolate_property(sprite, "modulate", Color("FF0000"), Color("FFFFFF"), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()
	knockback(origin)

func heal(value: int) -> void:
	health += value
	if health > health_max:
		health = health_max

	tween.interpolate_property(sprite, "modulate", Color("00FF00"), Color("FFFFFF"), 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

func knockback(origin, force := 25):
	knocked_back = true
	knockback_timer.start()

func is_health_max():
	return health == health_max

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if health <= 0:
		queue_free()

func _on_KnockbackTimer_timeout() -> void:
	knocked_back = false

func _on_KnockbackChecker_body_entered(body: PhysicsBody2D) -> void:
	if self != Global.Boy:
		knockback(body, 10)
