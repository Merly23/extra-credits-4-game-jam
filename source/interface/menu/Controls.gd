extends Panel

func _on_Back_pressed() -> void:
	Audio.play_button()
	Scene.change(Scene.TitleScreen)