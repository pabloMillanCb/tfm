extends Node2D


func _ready() -> void:
	$Time.text = Clock.get_time_formated()
