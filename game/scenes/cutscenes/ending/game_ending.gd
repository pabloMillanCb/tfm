extends Node2D


func _ready() -> void:
	DataManager.complete_game()
	$Time.text = Clock.get_time_formated()
	var percentage = DataManager.current_save.player_data.max_health
	if percentage != null:
		%Completion.text = str((percentage-3)*20) + "%"



func _on_timer_timeout() -> void:
	$AnimationPlayer.play("credits")
	$Node2D.visible = true
	$AudioStreamPlayer.play()


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
