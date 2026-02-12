extends Enemy
class_name Jellyfish

@export var radius := 20.0
@export var rotation_speed := 2.0

func _ready() -> void:
	%JellyPosition.position.y = -radius


func _process(delta: float) -> void:
	
	var start_character_position = $Character.global_position
	
	$RotationAxis.rotate(delta * rotation_speed)
	$Character.global_position = %JellyPosition.global_position

	var direction = sign(start_character_position.x - $Character.global_position.x)
	
	$Character.scale.x = direction


func die():
	queue_free()
