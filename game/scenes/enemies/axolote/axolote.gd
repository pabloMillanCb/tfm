extends EnemyCharacter
class_name Axolote

@export var walk_speed := 25.0
@export var run_speed := 75.0
@export var move_direction := -1.0

@onready var raycast: RayCast2D = %RayCast2D
@onready var state_machine: StateMachine = (func get_state_machine() -> StateMachine:
	return get_node("StateMachine")
).call()

@onready var turn_cooldown: Timer = $TurnCooldown

var can_take_hits = true


func update_gravity(_delta):
	var GRAVITY_FORCE = 200
	if not is_on_floor():
		velocity.y += GRAVITY_FORCE * _delta


func is_player_on_sight() -> bool:
	var object = raycast.get_collider()
	return object is Player


func is_turn_around_needed():
	var point = raycast.get_collision_point()
	var object = raycast.get_collider()
	return (global_position.distance_to(point) <= 10
		and not object is Player)


func set_animation(animation: String):
	$AnimatedSprite2D.play(animation)


func change_direction():
	if turn_cooldown.time_left == 0:
		move_direction = move_direction * -1
		$AnimatedSprite2D.scale.x = $AnimatedSprite2D.scale.x * -1
		turn_cooldown.start(1.0)


func take_damage(direction: Vector2 = Vector2.ZERO):
	print("ouch")
	if can_take_hits:
		state_machine._transition_to_next_state(AxoloteState.HIT)
