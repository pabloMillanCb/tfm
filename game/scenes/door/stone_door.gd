extends StaticBody2D
class_name StoneDoor

@export var locked = false

func _ready() -> void:
	if locked:
		$CollisionShape2D.position.y = 49.5

func unlock_door():
	$AnimationPlayer.play("open")

func lock_door():
	$AnimationPlayer.play("close")
