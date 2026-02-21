extends Node2D

var player: Player

func _on_player_detector_body_entered(body: Node2D) -> void:
	player = body
	$AnimationPlayer.play("save")


func save_game():
	DataManager.save_game_in_room(player.data)
