extends Node2D


func _ready() -> void:
	$Time.text = Clock.get_time_formated()


func _on_timer_timeout() -> void:
	$AnimationPlayer.play("credits")
	$Node2D.visible = true
	$AudioStreamPlayer.play()


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
