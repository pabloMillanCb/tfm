extends Node2D

func _ready() -> void:
	%Retry.grab_focus()


func _on_main_menu_pressed() -> void:
	GameEvent._on_return_to_title_screen.emit()


func _on_retry_pressed() -> void:
	GameEvent._on_player_respawn.emit()
