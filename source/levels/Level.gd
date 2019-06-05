extends Node2D

onready var navigation := $Navigation2D as Navigation2D
onready var terrain := $Navigation2D/Terrain as TileMap

onready var game_cam := $GameCam as GameCam

onready var boy := $Characters/Player/Boy
onready var girl := $Characters/Player/Girl

func _ready() -> void:
	Audio.play_ambience()
	Audio.play_game_music()
	Global.Navigation = navigation
	Global.Terrain = terrain