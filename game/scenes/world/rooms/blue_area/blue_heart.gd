extends Node2D

const EVENT_NAME = "BlueHeartWaveCompleted"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !DataManager.is_event_registered(EVENT_NAME):
		$Door/CollisionShape2D.disabled = true
		$EnemyWave.activate_wave()
		$Door.lock_door()
		$Door2.lock_door()
		$Area2D.queue_free()


func _on_enemy_wave_3_on_wave_end() -> void:
	DataManager.register_event(EVENT_NAME, true)
