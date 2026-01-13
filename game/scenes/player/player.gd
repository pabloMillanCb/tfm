extends CharacterBody2D
class_name Player

@export var debug_mode = false

@export var walking_speed = 100
@export var walking_acceleration = 400

@onready var state_machine: StateMachine = (func get_state_machine() -> StateMachine:
	return get_node("StateMachine")
).call()

func _process(delta: float) -> void:
	%DebugStateName.visible = debug_mode

func set_animation(animation_name: String):
	if animation_name == "atack":
		$PlayerSprites/AnimationPlayer.play("atack")
	else:
		$PlayerSprites.play(animation_name)

func update_look_direction():
	if velocity.x > 0:
		$PlayerSprites.scale.x = 1
	elif velocity.x < 0:
		$PlayerSprites.scale.x = -1
