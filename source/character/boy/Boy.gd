extends Character
class_name Boy

enum ANIMATION {IDLE, WALK, ATTACK, DIE }

var motion := Vector2(0, 0)

export(ANIMATION) var animation = ANIMATION.IDLE

export var damage := 6

onready var stick_area := $StickArea

func _ready() -> void:

	Global.Boy = self
	anim_tree.active = true

	state_machine.register_state("idle", "Idle")
	state_machine.register_state("walk", "Walk")
	state_machine.register_state("attack", "Attack")
	state_machine.register_state("dead", "Dead")
	state_machine.change_state("idle")

	get_tree().call_group("Doll", "set_target_node", self)

func set_frame_offset(facing, animation):
	self.facing = facing
	self.animation = animation
	var frame_offset = frame_size.y * (animation * 4 + facing)

	if sprite:
		sprite.region_rect = Rect2(Vector2(0, frame_offset), sprite.region_rect.size)

	match facing:
		FACING.UP: stick_area.position = Vector2(0, -17)
		FACING.DOWN: stick_area.position = Vector2(0, 7)
		FACING.LEFT: stick_area.position = Vector2(-14, -7)
		FACING.RIGHT: stick_area.position = Vector2(14, -7)

func slash():
	var bodies = stick_area.get_overlapping_bodies()

	for body in bodies:
		if body is Character and not body == self and not body is Girl:
			body.harm(self, damage)

		if body is Orb:
			body.destroy()

func harm(origin, damage: int) -> void:
	.harm(origin, damage)
	Audio.play_boy_hit()
	knockback(origin, 10)

func knockback(origin, force := 25):
	.knockback(origin, force)

	var direction := Vector2()

	if not origin:
		direction = -knockback_direction
	else:
		direction = -(origin.global_position - global_position).normalized()

	knockback_direction = direction

	tween.stop(self, "global_position")
	tween.interpolate_property(self, "global_position", global_position, global_position + force * direction, 0.25, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

func play_slash():
	Audio.play_boy_slash()

func play_step():
	Audio.play_boy_foodstep()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if health <= 0:
		state_machine.change_state("dead")