extends Control

const fade_time = 0.5
const menu_offset = Vector2(0, -200)

onready var tween := $Tween as Tween

onready var menu := $Layer2/PopupPanel
onready var background := $Layer1/TextureRect

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle()

func _ready() -> void:
	menu.rect_global_position += menu_offset
	background.hide()

func toggle() -> void:
	if background.visible:
		fade_out()
	else:
		fade_in()

func fade_in() -> void:
	get_tree().paused = true
	tween.stop_all()
	background.modulate = Color("00FFFFFF")
	background.show()

	tween.interpolate_property(background, "modulate", Color("00FFFFFF"), Color("FFFFFFFF"), fade_time / 2, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.interpolate_property(menu, "rect_global_position", menu.rect_global_position, menu.rect_global_position - menu_offset, fade_time, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()

func fade_out() -> void:
	tween.stop_all()

	tween.interpolate_property(background, "modulate", Color("FFFFFFFF"), Color("00FFFFFF"), fade_time / 2, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(menu, "rect_global_position", menu.rect_global_position, menu.rect_global_position + menu_offset, fade_time, Tween.TRANS_BACK, Tween.EASE_IN)
	tween.start()

func _on_Tween_tween_all_completed() -> void:
	if background.modulate == Color("00FFFFFF"):
		get_tree().paused = false
		background.hide()

func _on_Resume_pressed() -> void:
	fade_out()

func _on_Quit_pressed() -> void:
	get_tree().paused = false
	Scene.change(Scene.TitleScreen)
