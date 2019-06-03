extends CanvasLayer

# Scenes
const TitleScreen := "res://source/interface/menu/TitleScreen.tscn"
const Level1 := "res://source/levels/Level1.tscn"

var next_scene := ""

onready var scene_loader := $SceneLoader as SceneLoader
onready var anim := $AnimationPlayer as AnimationPlayer
onready var progress_bar := $ProgressBar as ProgressBar

func change(scene: String) -> void:
	next_scene = scene
	anim.play("fade_out")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_out":
		scene_loader.load_interactive(next_scene)
		progress_bar.max_value = scene_loader.get_stage_count()

func _on_ProgressBar_value_changed(value: float) -> void:
	if progress_bar.max_value == value:
		progress_bar.visible = false
	elif not progress_bar.visible:
		progress_bar.visible = true

func _on_SceneLoader_scene_loaded(scene) -> void:
	get_tree().change_scene_to(scene)
	anim.play("fade_in")
	next_scene = ""

func _on_SceneLoader_stage_changed(stage) -> void:
	progress_bar.value = stage