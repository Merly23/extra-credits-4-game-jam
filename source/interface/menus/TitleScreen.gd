extends Control

func _on_Game_pressed() -> void:
	Scene.change(Scene.Game)

func _on_Exit_pressed() -> void:
	get_tree().quit()