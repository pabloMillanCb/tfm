extends Node2D

func _ready() -> void:
	%Retry.grab_focus()


func _on_main_menu_pressed() -> void:
	GameEvent._on_return_to_title_screen.emit()


func _on_retry_pressed() -> void:
	$AnimatedSprite2D.play("open")
	$AudioStreamPlayer.play()
	await get_tree().create_timer(1.5).timeout
	DataManager.reload_current_save()
	GameEvent._on_player_respawn.emit()
