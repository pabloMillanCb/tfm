extends Area2D

enum COLOR {GREY, ORANGE, BLUE}

@export var color: COLOR

func _ready() -> void:
	if color == COLOR.ORANGE:
		$AnimatedSprite2D.play("orange")
	if color == COLOR.BLUE:
		$AnimatedSprite2D.play("blue")

func take_damage(_vector: Vector2):
	queue_free()
