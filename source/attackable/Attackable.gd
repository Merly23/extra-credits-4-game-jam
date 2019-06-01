extends Node2D
class_name Attackable

var health := 0

export var health_max := 3

onready var health_bar := $HealthBar

func _ready():
	health = health_max
	health_bar.max_value = health_max
	health_bar.value = health

func harm(damage: int) -> void:
	health -= damage
	health_bar.value = health

	if health < 1:
		queue_free()
