extends Node2D
class_name SettingsMenu

signal exited

func _ready() -> void:
	$CenterContainer/VBoxContainer/Back.grab_focus()


func _on_back_pressed() -> void:
	exited.emit()
