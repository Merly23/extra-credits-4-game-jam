extends Character
class_name Boy

enum ANIMATION {IDLE, WALK, ATTACK }

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
	state_machine.change_state("idle")

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

func slash():
	var areas = stick_area.get_overlapping_areas()
	var bodies = stick_area.get_overlapping_bodies()

	for area in areas:

		if area is Orb:
			area.destroy()

	for body in bodies:
		if body is Character and not body == self and not body is Girl:
			body.harm(damage)

func play_slash():
	Audio.play_boy_slash()

func play_step():
	Audio.play_boy_foodstep()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if health <= 0:
		Scene.change(Scene.GameOver)