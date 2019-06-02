extends Node2D

onready var navigation := $Navigation2D as Navigation2D
onready var terrain := $Navigation2D/Terrain as TileMap

onready var game_cam := $GameCam as GameCam

onready var boy := $Characters/Player/Boy
onready var girl := $Characters/Player/Ghost

func _ready() -> void:
	Global.Navigation = navigation
	Global.Terrain = terrain

func _process(delta: float) -> void:
	game_cam.update_position(boy.global_position, girl.global_position)