extends Node2D
class_name PlayerParticles


func _on_hit(direction: Vector2) -> void:
	$HitParticle.direction = direction
	$HitParticle.gravity = -direction.normalized() * 340
	$HitParticle.restart()


func _on_death(scale: float) -> void:
	if scale == -1:
		var img = $DeadHeadParticle.texture.get_image()
		img.flip_x()
		$DeadHeadParticle.texture = ImageTexture.create_from_image(img)
	$DeadBodyParticle.restart()
	$DeadHeadParticle.restart()
