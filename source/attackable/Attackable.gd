extends Node2D
class_name Attackable

var health := 0

export var health_max := 3

onready var health_bar := $HealthBar as TextureProgress

onready var tween := $Tween as Tween

func _ready():
	health = health_max
	health_bar.max_value = health_max
	health_bar.value = health

func harm(damage: int) -> void:
	health -= damage
	tween.interpolate_property(health_bar, "value", health_bar.value, health, 0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if health <= 0:
		queue_free()
