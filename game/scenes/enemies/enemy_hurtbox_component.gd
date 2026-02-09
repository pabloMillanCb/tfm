extends Area2D

signal player_atack_detected


func _on_area_entered(area: Area2D) -> void:
	print("received")
	player_atack_detected.emit()
