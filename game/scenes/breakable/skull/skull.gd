extends Breakable

func take_damage(direction: Vector2 = Vector2.ZERO):
	print("take_damage")
	$StaticBody2D/CollisionShape2D.set_deferred("disabled",true)
	$HurtboxComponent/CollisionShape2D.set_deferred("disabled",true)
	$Sprite2D.visible = false
	$Timer.start()


func _on_timer_timeout() -> void:
	$StaticBody2D/CollisionShape2D.set_deferred("disabled",false)
	$HurtboxComponent/CollisionShape2D.set_deferred("disabled",false)
	$Sprite2D.visible = true
