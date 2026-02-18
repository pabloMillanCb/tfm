extends EnemyCharacter
class_name TriangleFish


@export var speed = 20.0

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var state_machine: StateMachine = (func get_state_machine() -> StateMachine:
	return get_node("StateMachine")
).call()

var player: Player
var can_take_hits = true


func set_animation(animation: String):
	$AnimatedSprite2D.play(animation)


func _on_player_detected(body: Node2D) -> void:
	player = body


func update_direction(direction: Vector2):
	if direction.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true


func take_damage():
	print("ouch")
	if can_take_hits:
		state_machine._transition_to_next_state(TriangleFishState.HIT)


func _on_start_timer_timeout() -> void:
	$PlayerDetect/CollisionShape2D.disabled = false
