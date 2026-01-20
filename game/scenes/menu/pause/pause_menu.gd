extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/VBoxContainer/Resume.grab_focus()


func _on_resume_pressed() -> void:
	print("unpause")
	GameManager.unpause_game()


func _on_settings_pressed() -> void:
	GameManager.go_to_title_screen()


func _on_main_menu_pressed() -> void:
	pass # Replace with function body.
