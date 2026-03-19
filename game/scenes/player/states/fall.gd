extends PlayerState
class_name FallState

@export var coyote_timer: Timer
@export var super_fall_timer: Timer

var animation_name = "fall"
var sound_name = "land"
var vibration_force = 0.05
var vibration_time = 0.1

func _enter(_previous_state_path: String, _init_data := {}):
	if _init_data.get("coyote_time") == true:
		coyote_timer.start()
	else:
		player.set_animation(animation_name)
	
	super_fall_timer.start()

func _update(_delta):
	player.update_gravity(_delta)

	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		player.velocity.x = move_toward(
			player.velocity.x, 
			player.walking_speed * direction, 
			_delta * player.air_acceleration) 
	
	if coyote_timer.time_left == 0:
		player.set_animation(animation_name)
	
	if super_fall_timer != null:
		if super_fall_timer.time_left < 0.25:
			player.set_animation("super_fall")
	
	if coyote_timer.time_left > 0 and Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	elif (Input.is_action_just_pressed("atack")
		and Input.is_action_pressed("aim_down")
		and player.data.has_pogo_update):
		finished.emit(POGO)
	elif Input.is_action_just_pressed("teleport") and player.data.has_teleport_update:
		finished.emit(PREPARE_TELEPORT)
	elif Input.is_action_just_pressed("atack") and player.data.has_sword_update:
		finished.emit(ATACK)
	elif player.velocity.y <= 0:
		player.set_animation("jump")
	elif player.is_on_floor():
		player.play_sound(sound_name, 0.1)
		Input.start_joy_vibration(0,vibration_force,vibration_force,vibration_time)
		if player.velocity.x != 0:
			finished.emit(MOVE)
		else:
			finished.emit(IDLE)
	
	player.move_and_slide()

func _exit():
	$ToSuperFall.stop()


func _on_to_super_fall_timeout() -> void:
	finished.emit(SUPER_FALLING)
