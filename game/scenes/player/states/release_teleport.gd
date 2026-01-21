extends PlayerState

@export var cooldown_time = 0.5
@export var release_teleport_time = 0.1
var time = 0.0

func _enter(_previous_state_path: String, _init_data := {}):
	player.set_animation("release_teleport")
	time = 0.0
	player.teleport()


func _update(_delta):
	time += _delta
	
	if time > cooldown_time:
		finished.emit(IDLE)
