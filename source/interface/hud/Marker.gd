extends Control

onready var tween := $Tween as Tween

func _ready() -> void:
	Global.Marker = self
	modulate = Color("00FFFFFF")

func mark(pos: Vector2) -> void:
	rect_global_position = pos
	tween.interpolate_property(self, "modulate", Color("FFFFFFFF"), Color("00FFFFFF"), 0.4, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	tween.start()