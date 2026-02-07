extends Node2D
class_name PlayerParticles


func _on_hit(direction: Vector2) -> void:
	$HitParticle.direction = direction
	$HitParticle.gravity = -direction.normalized() * 340
	$HitParticle.restart()
