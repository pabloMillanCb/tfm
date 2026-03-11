extends Area2D


func _on_body_entered(body: Node2D) -> void:
	GameEvent._on_game_completed.emit()
