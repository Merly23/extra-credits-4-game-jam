extends Panel

func _ready() -> void:
	Audio.stop_music()

func _on_Again_pressed() -> void:
	Scene.change(Scene.Level1)

func _on_Quit_pressed() -> void:
	Scene.change(Scene.TitleScreen)