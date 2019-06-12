extends Character
class_name Doll

enum ANIMATION { IDLE, WALK, ATTACK, DIE }

var motion := Vector2(0, 0)

var attack_reach := 25

var _target = null

export(ANIMATION) var animation = ANIMATION.IDLE

export var damage := 6
export var reach := 120

export(NodePath) var target = null

onready var stick_area := $StickArea

func _ready() -> void:
	anim_tree.active = true
	state_machine.register_state("idle", "Idle")
	state_machine.register_state("walk", "Walk")
	state_machine.register_state("attack", "Attack")
	state_machine.register_state("dead", "Dead")
	state_machine.change_state("idle")
	_set_target(target)

func get_target_position():
	if _target:
		return _target.global_position
	return global_position

func set_frame_offset(facing, animation):
	self.facing = facing
	self.animation = animation
	var frame_offset = frame_size.y * (animation * 4 + facing)

	if sprite:
		sprite.region_rect = Rect2(Vector2(0, frame_offset), sprite.region_rect.size)

	match facing:
		FACING.UP: stick_area.position = Vector2(0, -21)
		FACING.DOWN: stick_area.position = Vector2(0, 7)
		FACING.LEFT: stick_area.position = Vector2(-14, -7)
		FACING.RIGHT: stick_area.position = Vector2(14, -7)

func is_target_in_attack_reach() -> bool:
	if _target:
		var distance = (_target.global_position - global_position).length()
		return distance < attack_reach
	return false

func is_target_in_sight() -> bool:
	if _target:
		var distance = (_target.global_position - global_position).length()
		return distance < reach
	return false

func slash():
	var areas = stick_area.get_overlapping_areas()
	var bodies = stick_area.get_overlapping_bodies()

	for body in bodies:
		if body is Character and not body == self:
			body.harm(damage)

func has_health():
	return health > 0

func knockback():
	var knockback = 25

	var direction = (Global.Boy.global_position - global_position).normalized()

	tween.interpolate_property(self, "global_position", global_position, global_position + knockback * -direction, 0.1, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

func harm(damage: int) -> void:
	.harm(damage)
	Audio.play_doll_hit()

func play_slash():
	Audio.play_doll_slash()

func play_die():
	Audio.play_doll_die()

func set_target_node(value):
	_target = value

func _set_target(value):
	if value:
		_target = get_node(target)

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if health <= 0:
		state_machine.change_state("dead")
