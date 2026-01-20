extends Node2D
class_name TeleportCrosshair

@export var speed_curve: Curve
@export var max_distance = 80.0
@export var direction = 1

var time = 0.0

func _physics_process(delta: float) -> void:
	time += delta
	var rotation_speed = 3
	$Area2D.rotation += delta * rotation_speed
	$Area2D.position.x = speed_curve.sample(time) * max_distance * direction

func get_aim_global_position() -> Vector2:
	return $Area2D.global_position
