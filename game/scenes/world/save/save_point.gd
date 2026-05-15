extends Node2D

var player: Player

@export var message = "GAME_SAVED"

func _ready() -> void:
	$SaveGameLable.text = "[center][wave amp=50.0 freq=5.0 connected=1][font_size={30}]" + tr(message) +"[/font_size][/wave]"

func _on_player_detector_body_entered(body: Node2D) -> void:
	if player == null:
		player = body
		$AnimationPlayer.play("save")


func save_game():
	DataManager.save_game_in_room(player.data)
	player.heal()
