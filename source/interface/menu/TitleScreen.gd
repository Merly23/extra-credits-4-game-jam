extends Panel

func _ready() -> void:
	Audio.play_menu_music()

func _on_Game_pressed() -> void:
	Audio.play_button()
	Scene.change(Scene.Level1, true)

func _on_Controls_pressed() -> void:
	Audio.play_button()
	Scene.change(Scene.Controls)

func _on_Credits_pressed() -> void:
	Audio.play_button()
	Scene.change(Scene.Credits)

func _on_Exit_pressed() -> void:
	Audio.play_button()
	get_tree().quit()
