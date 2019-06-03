extends Panel

func _on_Game_pressed() -> void:
	Scene.change(Scene.Level1)

func _on_Controls_pressed() -> void:
	Scene.change(Scene.Controls)

func _on_Credits_pressed() -> void:
	Scene.change(Scene.Credits)

func _on_Exit_pressed() -> void:
	get_tree().quit()
