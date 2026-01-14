extends CharacterBody2D
class_name Player

@export var debug_mode = false

@export var walking_speed = 80
@export var walking_acceleration = 400
@export var jump_force = -120

@onready var state_machine: StateMachine = (func get_state_machine() -> StateMachine:
	return get_node("StateMachine")
).call()

func _process(delta: float) -> void:
	%DebugStateName.visible = debug_mode

func stop_animation():
	$PlayerSprites.stop()
	$PlayerSprites/AnimationPlayer.stop()

func set_animation(animation_name: String):
	if animation_name == "atack":
		$PlayerSprites/AnimationPlayer.play("atack")
	else:
		$PlayerSprites.play(animation_name)

func update_look_direction(force = false):
	var input_direction = Input.get_axis("move_left", "move_right")
	if force and input_direction:
		$PlayerSprites.scale.x = input_direction
	else:
		if velocity.x > 0:
			$PlayerSprites.scale.x = 1
		elif velocity.x < 0:
			$PlayerSprites.scale.x = -1

func update_gravity(_delta):
	
	var JUMP_GRAVITY_FORCE = 200
	var FALL_GRAVITY_FORCE = 400
	var MAX_FALL_SPEED = 450
	
	if velocity.y > 0 or !Input.is_action_pressed("jump"):
		velocity.y = move_toward(velocity.y, MAX_FALL_SPEED, _delta * FALL_GRAVITY_FORCE)
	else:
		velocity.y += JUMP_GRAVITY_FORCE * _delta
