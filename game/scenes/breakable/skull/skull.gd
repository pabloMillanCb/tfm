extends Breakable

@export var permanent = true

func _ready() -> void:
	if !permanent:
		MetSys.register_storable_object(self)

func place_particles():
	var particles = preload("res://scenes/breakable/breakable_particles.tscn").instantiate()
	particles.is_wall = false
	particles.global_position = global_position
	get_parent().add_child(particles)

func take_damage(direction: Vector2 = Vector2.ZERO):
	print("take_damage")
	place_particles()
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
