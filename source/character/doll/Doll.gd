extends Character
class_name Doll

enum ANIMATION { IDLE, WALK, ATTACK }

var motion := Vector2(0, 0)
var reach := 25

var _target = null

export(ANIMATION) var animation = ANIMATION.IDLE

export var damage := 6
export(NodePath) var target = null

onready var stick_area := $StickArea

func _ready() -> void:
	anim_tree.active = true
	state_machine.register_state("idle", "Idle")
	state_machine.register_state("walk", "Walk")
	state_machine.register_state("attack", "Attack")
	state_machine.change_state("idle")
	_set_target(target)

func set_frame_offset(facing, animation):
	self.facing = facing
	self.animation = animation
	var frame_offset = frame_size.y * (animation * 4 + facing)

	if sprite:
		sprite.region_rect = Rect2(Vector2(0, frame_offset), sprite.region_rect.size)

	match facing:
		FACING.UP: stick_area.position = Vector2(0, -9)
		FACING.DOWN: stick_area.position = Vector2(0, 19)
		FACING.LEFT: stick_area.position = Vector2(-14, 5)
		FACING.RIGHT: stick_area.position = Vector2(14, 5)

func is_target_in_reach() -> bool:
	if _target:
		var distance = (_target.global_position - global_position).length()
		return distance < reach
	return false

func slash():
	var areas = stick_area.get_overlapping_areas()
	var bodies = stick_area.get_overlapping_bodies()

	for area in areas:
		if area is Attackable:
			area.harm(damage)

	for body in bodies:
		if body is Character and not body == self:
			body.harm(damage)

func get_direction_to_target():
	pass

func play_slash():
	Audio.play_boy_slash()

func play_step():
	pass # Audio.play_boy_foodstep()

func _set_target(value):
	_target = get_node(target)