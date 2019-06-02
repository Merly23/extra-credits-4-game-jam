extends Character

enum ANIMATION {IDLE, WALK, ATTACK }

var motion := Vector2(0, 0)

export(ANIMATION) var animation = ANIMATION.IDLE

export var speed := 180
export var damage := 6

onready var stick_area := $StickArea

func _ready() -> void:
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

	for area in areas:
		if area is Attackable:
			area.harm(damage)
		break;

func play_slash():
	Audio.play_boy_slash()

func play_step():
	Audio.play_boy_foodstep()