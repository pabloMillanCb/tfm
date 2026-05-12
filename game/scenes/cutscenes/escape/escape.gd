extends Node2D

var pitch = 2.0

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	%Boing.play()
	$AnimationPlayer.play("up")
	$Node2D.visible = true
func _on_audio_stream_player_finished() -> void:
	await get_tree().create_timer(0.32).timeout
	pitch += 0.1
	%Boing.pitch_scale = pitch
	%Boing.play()
