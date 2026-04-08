extends Node2D

var player: Node2D = null

func _process(delta: float) -> void:
	if player != null:
		var distance_to_end = player.global_position.distance_to($Area2D.global_position)
		if distance_to_end < 140:
			var modulate = (140-distance_to_end)/150
			print(modulate)
			$CanvasLayer/ColorRect.color.a = modulate
		else:
			$CanvasLayer/ColorRect.color.a = 0.0
			
	
	if $AudioStreamPlayer2D.playing == false:
		$AudioStreamPlayer2D.play()

func _on_player_detector_body_entered(body: Node2D) -> void:
	player = body
