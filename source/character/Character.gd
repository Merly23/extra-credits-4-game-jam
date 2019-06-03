extends KinematicBody2D
class_name Character

enum FACING { DOWN, RIGHT, UP, LEFT }

var health := 0

export(FACING) var facing := FACING.DOWN

export var health_max := 20

export var frame_size := Vector2(16, 16)

onready var anim_player := $AnimationPlayer as AnimationPlayer
onready var anim_tree := $AnimationTree as AnimationTree
onready var anim = anim_tree.get("parameters/playback")
onready var tween := $Tween as Tween

onready var audio_player := $AudioStreamPlayer

onready var sprite := $Sprite as Sprite

onready var health_bar := $HealthBar as TextureProgress

onready var state_machine = $StateMachine as StateMachine

func _ready() -> void:
	state_machine.host = self
	health = health_max
	health_bar.max_value = health_max
	health_bar.value = health

func _on_StateMachine_state_changed(state_name) -> void:
	$State.text = state_name

func harm(damage: int) -> void:
	health -= damage
	tween.interpolate_property(health_bar, "value", health_bar.value, health, 0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if health <= 0:
		queue_free()