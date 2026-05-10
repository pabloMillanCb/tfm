extends Area2D

enum COLOR {GREY, ORANGE, BLUE}

@export var color: COLOR

func _ready() -> void:
	if color == COLOR.ORANGE:
		$AnimatedSprite2D.play("orange")
	if color == COLOR.BLUE:
		$AnimatedSprite2D.play("blue")
		
	MetSys.register_storable_object(self)

func take_damage(_vector: Vector2):
	place_particles()
	Input.start_joy_vibration(0,0.8,0.8,0.4)
	MetSys.store_object(self)
	queue_free()

func place_particles():
	var particles = preload("res://scenes/breakable/breakable_particles.tscn").instantiate()
	particles.is_wall = false
	particles.global_position = global_position
	get_parent().add_child(particles)
