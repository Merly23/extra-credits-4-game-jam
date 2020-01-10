extends Character
class_name Doll

# may be subject to cyclic reference
var target : Character = null

export var vision := 120
export var attack_range := 20

onready var vision_area_shape := $VisionArea/CollisionShape2D as CollisionShape2D

func _ready() -> void:
	vision_area_shape.shape.radius = vision
	change_state("idle")

func hit() -> void:
	pass

func attack_finished() -> void:
	change_state("idle")

func _on_VisionArea_body_entered(body: PhysicsBody2D) -> void:
	if body is Character and body.team_number != team_number:
		target = body
