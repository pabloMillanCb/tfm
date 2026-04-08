extends CharacterBody2D

@export var target: Node2D
@onready var navigation_agentd: NavigationAgent2D = $NavigationAgent2D

var direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if navigation_agentd.distance_to_target() > 20:
		direction = direction.move_toward(get_direction_to_chase(), delta * 2)
	velocity = direction * 50
	move_and_slide()

func get_direction_to_chase():
	return (navigation_agentd.get_next_path_position() - global_position).normalized()


func _on_timer_timeout() -> void:
	navigation_agentd.target_position = target.global_position
