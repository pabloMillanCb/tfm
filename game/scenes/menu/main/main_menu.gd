extends Node2D


func _ready() -> void:
	$CenterContainer/VBoxContainer/New.grab_focus()


func _on_new_pressed() -> void:
	GameManager.start_new_game()


func _on_load_pressed() -> void:
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	pass # Replace with function body.
