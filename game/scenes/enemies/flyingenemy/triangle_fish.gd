extends EnemyCharacter
class_name TriangleFish


@export var speed = 100.0
var player: Player


func set_animation(animation: String):
	$AnimatedSprite2D.play(animation)


func _on_player_detected(body: Player) -> void:
	player = body
