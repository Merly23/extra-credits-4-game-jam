extends Character

enum ANIMATION {IDLE, WALK, ATTACK }

var motion := Vector2(0, 0)

export(ANIMATION) var animation = ANIMATION.IDLE

export var speed := 180
export var damage := 6

onready var stick_area := $StickArea

#func _unhandled_input(event: InputEvent) -> void:
#	if event.is_action_pressed("mouse_right_button"):
#		_attack()

func _ready() -> void:
	state_machine.register_state("idle", "Idle")
	state_machine.register_state("walk", "Walk")
	state_machine.register_state("attack", "Attack")
	state_machine.change_state("idle")

func set_frame_offset(facing, animation):
	self.facing = facing
	self.animation = animation
	var frame_offset = frame_size.y * (animation * 4 + facing)

	# print("FACING: ", facing, " ANIM: ", animation, " OFFSET: ", frame_offset)

	if sprite:
		sprite.region_rect = Rect2(Vector2(0, frame_offset), sprite.region_rect.size)

#	var areas = stick_area.get_overlapping_areas()
#
#	for area in areas:
#		if area is Attackable:
#			area.harm(damage)


#func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
#	if anim_name.begins_with("attack"):
#		anim.play("idle")
