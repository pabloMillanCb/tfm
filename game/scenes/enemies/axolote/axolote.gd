extends EnemyCharacter
class_name Axolote

@onready var raycast: RayCast2D = $AnimatedSprite2D/RayCast2D

@onready var state_machine: StateMachine = (func get_state_machine() -> StateMachine:
	return get_node("StateMachine")
).call()


func update_gravity(_delta):
	var GRAVITY_FORCE = 200
	if not is_on_floor():
		velocity.y += GRAVITY_FORCE * _delta


func is_raycast_colliding_player() -> bool:
	var object = raycast.get_collider()
	return object is Player
