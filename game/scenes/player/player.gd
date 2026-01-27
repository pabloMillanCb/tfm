extends CharacterBody2D
class_name Player

@export var debug_mode = false

@export var walking_speed = 80
@export var walking_acceleration = 1200
@export var pogo_acceleration = 2400
@export var air_acceleration = 300
@export var jump_force = -120
@export var bounce_force = -150
@export var beam_update = false
@export var break_update = false

signal dialog_start_request(dialogue_component: DialogueComponent)

@onready var state_machine: StateMachine = (func get_state_machine() -> StateMachine:
	return get_node("StateMachine")
).call()

var teleport_crosshair: TeleportCrosshair

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


func get_look_direction():
	return $PlayerSprites.scale.x


func update_gravity(_delta):
	
	var JUMP_GRAVITY_FORCE = 200
	var FALL_GRAVITY_FORCE = 400
	var MAX_FALL_SPEED = 300
	
	if velocity.y > 0 or !Input.is_action_pressed("jump"):
		velocity.y = move_toward(velocity.y, MAX_FALL_SPEED, _delta * FALL_GRAVITY_FORCE)
	else:
		velocity.y += JUMP_GRAVITY_FORCE * _delta


func shoot():
	if beam_update:
		var beam: Beam = preload("res://scenes/player/beam/beam.tscn").instantiate()
		beam.direction = get_look_direction()
		beam.global_position = %ShootingPoint.global_position
		get_parent().add_child(beam)


func set_pogo_hitbox(active: bool):
	$PlayerSprites/PogoHitbox.monitoring = active
	$PlayerSprites/PogoHitbox.visible = active


func prepare_teleport():
	teleport_crosshair = preload("res://scenes/player/teleport/TeleportCrosshair.tscn").instantiate() 
	teleport_crosshair.direction = get_look_direction()
	teleport_crosshair.global_position = global_position
	get_parent().add_child(teleport_crosshair)


func teleport():
	if teleport_crosshair != null:
		global_position = teleport_crosshair.get_aim_global_position()
		teleport_crosshair.queue_free()


func _on_atack_hit(area: Area2D) -> void:
	if area.has_method("break_self") and break_update:
		area.break_self()
