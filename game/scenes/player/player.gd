extends CharacterBody2D
class_name Player

@export var debug_mode = false

@export var walking_speed = 80
@export var walking_acceleration = 1200
@export var walking_deceleration = 1200
@export var pogo_acceleration = 2400
@export var air_acceleration = 300
@export var jump_force = -120
@export var bounce_force = -150
@export var gravity_jumping = 200.0
@export var gravity_falling = 400.0
@export var max_fall_speed = 300.0
@export var debug_data: PlayerData =  null

@onready var data: PlayerData = (func set_debug_data() -> PlayerData:
	if debug_data != null:
		return debug_data
	else:
		return PlayerData.new()
).call()

var invencible = false
var current_health = 2

signal dialog_start_request(dialogue_component: DialogueComponent)

@onready var state_machine: StateMachine = (func get_state_machine() -> StateMachine:
	return get_node("StateMachine")
).call()

var teleport_crosshair: TeleportCrosshair


func _ready() -> void:
	update_upgrades_information()


func _process(delta: float) -> void:
	%DebugStateName.visible = debug_mode
	
	#if invencible:
	#	$PlayerSprites/AnimationPlayer.play("blink")
	if invencible:
		$PlayerSprites.material.set_shader_parameter("whiten", true)
		$PlayerSprites.material.set_shader_parameter("time", %InvencibleTimer.time_left)
	else:
		$PlayerSprites.material.set_shader_parameter("whiten", false)


func set_player_data(loaded_data: PlayerData):
	#if debug_data == null:
	data = loaded_data.copy()
	update_upgrades_information()
	update_health_information()
	instance_saved_key()


func get_new_upgrade(upgrade: Upgrade.UpgradeType):
	if upgrade == Upgrade.UpgradeType.SWORD:
		data.has_sword_update = true
	elif upgrade == Upgrade.UpgradeType.BREAK:
		data.has_break_update = true
	elif upgrade == Upgrade.UpgradeType.BEAM:
		data.has_beam_update = true
	elif upgrade == Upgrade.UpgradeType.POGO:
		data.has_pogo_update = true
	elif upgrade == Upgrade.UpgradeType.TELEPORT:
		data.has_teleport_update = true
	
	update_upgrades_information()
	

func update_health_information():
	print("update_health")
	print(data.max_health)
	print(current_health)
	current_health = data.max_health
	GameEvent.update_health.emit(data.max_health, current_health)


func update_upgrades_information():
	$PlayerSprites/SwordSprites.visible = data.has_sword_update

func stop_animation():
	$PlayerSprites.stop()
	$PlayerSprites/AnimationPlayer.pause()
	$PlayerSprites/SwordSprites.pause()


func set_animation(animation_name: String):
	if $PlayerSprites/AnimationPlayer.has_animation(animation_name):
		$PlayerSprites/AnimationPlayer.play(animation_name)
	else:
		$PlayerSprites.play(animation_name)
		if $PlayerSprites/SwordSprites.sprite_frames.has_animation(animation_name):
			$PlayerSprites/SwordSprites.play(animation_name)
		else:
			$PlayerSprites/SwordSprites.play("empty")

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


func update_gravity(_delta, force = false):
	
	var is_jump_pressed = Input.is_action_pressed("jump") or force
	
	if velocity.y < 0 and !is_jump_pressed:
		velocity.y = move_toward(velocity.y, max_fall_speed, _delta * gravity_falling * 2)
	elif velocity.y > 10 or velocity.y < -10 or !is_jump_pressed:
		velocity.y = move_toward(velocity.y, max_fall_speed, _delta * gravity_falling)
	else:
		velocity.y += gravity_jumping * _delta


func shoot():
	if data.has_beam_update:
		var beam: Beam = preload("res://scenes/player/beam/beam.tscn").instantiate()
		beam.direction = get_look_direction()
		beam.global_position = %ShootingPoint.global_position
		get_parent().add_child(beam)


func set_pogo_hitbox(active: bool):
	$PlayerSprites/PogoHitbox/CollisionShape2D.disabled = !active


func prepare_teleport():
	teleport_crosshair = preload("res://scenes/player/teleport/TeleportCrosshair.tscn").instantiate() 
	teleport_crosshair.direction = get_look_direction()
	teleport_crosshair.global_position = global_position
	get_parent().add_child(teleport_crosshair)


func teleport():
	if teleport_crosshair != null:
		global_position = teleport_crosshair.get_aim_global_position()
		teleport_crosshair.queue_free()


func _on_atack_hit(area: HurtboxComponent) -> void:
	if area.has_method("take_damage") and data.has_break_update:
		area.take_damage(-(area.global_position - global_position).normalized())


func _on_hit_received(_area: Area2D) -> void:
	if !invencible:
		(state_machine.state as PlayerState)._on_hit_received()


func force_jump():
	(state_machine.state as PlayerState).force_jump()


func set_sprite_visibility(visible: bool):
	$PlayerSprites.visible = visible


func instance_saved_key():
	if DataManager.current_save.player_data.has_key:
		var key = preload("res://scenes/key/Key.tscn").instantiate()
		key.global_position = global_position
		add_child(key)


func get_down_of_one_way_platform():
	position += Vector2(0.0, 1.0)


func _on_tile_hazard_touched(body: Node2D) -> void:
	if !invencible:
		(state_machine.state as PlayerState)._on_hit_received()
