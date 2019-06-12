extends Panel

var tween_time := 0.4

onready var tween := $Tween as Tween

onready var buttons := $CenterContainer/VBoxContainer.get_children()

func _ready() -> void:
	Audio.play_menu_music()

	for button in buttons:
		button.modulate = Color("00FFFFFF")

	call_deferred("_animate")

func _on_Game_pressed() -> void:
	Audio.play_button()
	Scene.change(Scene.Game, true)

func _on_Controls_pressed() -> void:
	Audio.play_button()
	Scene.change(Scene.Controls)

func _on_Credits_pressed() -> void:
	Audio.play_button()
	Scene.change(Scene.Credits)

func _on_Exit_pressed() -> void:
	Audio.play_button()
	get_tree().quit()

func _animate() -> void:
	tween.stop_all()
	tween.reset_all()

	for button in buttons:
		var start_pos = button.rect_global_position + Vector2(-200, 0)
		tween.interpolate_property(button, "modulate", button.modulate, Color("FFFFFFFF"), tween_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tween.interpolate_property(button, "rect_global_position", start_pos, button.rect_global_position, tween_time, Tween.TRANS_BACK, Tween.EASE_OUT)
		tween.start()
		yield(get_tree().create_timer(0.2), "timeout")