extends CanvasLayer

onready var boy_health_bar := $BoyHealthBar as TextureProgress
onready var girl_health_bar := $GirlHealthBar as TextureProgress

func update_boy_max_health(max_health: int) -> void:
	boy_health_bar.max_value = max_health

func update_girl_max_health(max_health: int) -> void:
	girl_health_bar.max_value = max_health

func update_boy_health(health: int) -> void:
	boy_health_bar.value = health

func update_girl_health(health: int) -> void:
	girl_health_bar.value = health
