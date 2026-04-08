extends Breakable

@export var permanent = true

func _ready() -> void:
	if !permanent:
		MetSys.register_storable_object(self)

func take_damage(direction: Vector2 = Vector2.ZERO):
	print("take_damage")
	Input.start_joy_vibration(0,0.4,0.4,0.1)
	if !permanent:
		MetSys.store_object(self)
		queue_free()
	else:
		$StaticBody2D/CollisionShape2D.set_deferred("disabled",true)
		$HurtboxComponent/CollisionShape2D.set_deferred("disabled",true)
		$Sprite2D.visible = false
		$Timer.start()


func _on_timer_timeout() -> void:
	$StaticBody2D/CollisionShape2D.set_deferred("disabled",false)
	$HurtboxComponent/CollisionShape2D.set_deferred("disabled",false)
	$Sprite2D.visible = true
