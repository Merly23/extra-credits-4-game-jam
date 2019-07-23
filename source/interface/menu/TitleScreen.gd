extends Panel

var tween_time := 0.4

onready var tween := $Tween as Tween

onready var buttons := $CenterContainer/VBoxContainer.get_children()

func _ready() -> void:
	Audio.play_song("Menu", 0.5)

	for button in buttons:
		button.modulate = Color("00FFFFFF")

	call_deferred("_animate")

func _animate() -> void:
	tween.stop_all()
	tween.reset_all()

	var time = 0
	for button in buttons:

		if not button.visible:
			continue

		var start_pos = button.rect_global_position + Vector2(-200, 0)
		tween.interpolate_property(button, "modulate", button.modulate, Color("FFFFFFFF"), tween_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT, time)
		tween.interpolate_property(button, "rect_global_position", start_pos, button.rect_global_position, tween_time, Tween.TRANS_BACK, Tween.EASE_OUT, time)
		time += 0.2

	tween.start()

func _on_NewGame_pressed() -> void:
	Scene.change(Scene.Game, true)

func _on_LoadGame_pressed() -> void:
	pass # Replace with function body.

func _on_Controls_pressed() -> void:
	Scene.change(Scene.Controls)

func _on_Credits_pressed() -> void:
	Scene.change(Scene.Credits)

func _on_Quit_pressed() -> void:
	get_tree().quit()





