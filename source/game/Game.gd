extends Node2D

onready var navigation := $Navigation2D as Navigation2D
onready var marker := $Marker as Control

func _ready() -> void:
	Audio.play_song("Level", 0.5)
	Global.Navigation = navigation
	Global.Marker = marker