extends KinematicBody2D
class_name Character

enum FACING { DOWN, RIGHT, UP, LEFT }

export(FACING) var facing := FACING.DOWN

export var frame_size := Vector2(16, 16)

onready var anim_player := $AnimationPlayer as AnimationPlayer
onready var anim_tree := $AnimationTree as AnimationTree
onready var anim = anim_tree.get("parameters/playback")
onready var sprite := $Sprite as Sprite

onready var state_machine = $StateMachine as StateMachine

func _ready() -> void:
	state_machine.host = self

func _on_StateMachine_state_changed(state_name) -> void:
	$State.text = state_name