extends Node2D

onready var navigation := $Navigation2D as Navigation2D
onready var marker := $Marker as Control

func _ready() -> void:
	Global.Navigation = navigation
	Global.Marker = marker