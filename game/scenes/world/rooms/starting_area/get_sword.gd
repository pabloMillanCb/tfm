extends Node2D

func _ready() -> void:
	if DataManager.get_event_value("sword_door_unlocked") == true:
		$Door.queue_free()

func _on_enemy_wave_on_wave_end() -> void:
	DataManager.register_event("sword_door_unlocked", true)
