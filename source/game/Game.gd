extends Node2D

onready var navigation := $Navigation2D as Navigation2D
onready var terrain := $Navigation2D/Terrain as TileMap

func _ready() -> void:
	Global.Navigation = navigation
	Global.Terrain = terrain