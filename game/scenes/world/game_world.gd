extends "res://addons/MetroidvaniaSystem/Template/Scripts/MetSysGame.gd"
class_name GameWorld

var do_respawn := true

func _ready() -> void:
	MetSys.reset_state()
	MetSys.set_save_data()
	
	set_player($Player)
	load_player_in_starting_room()
	spawn_in_current_room()
	
	#room_loaded.connect(spawn_in_current_room)
	
	add_module("RoomTransitions.gd")


func _process(delta: float) -> void:
	MetSys.get_current_room_instance().adjust_camera_limits($Player/Camera2D)
	
	#TODO DEBUG, TO DELETE
	if Input.is_action_just_pressed("save"):
		if Input.is_key_pressed(KEY_1):
			DataManager.save_game_in_room(0)
		elif Input.is_key_pressed(KEY_2):
			DataManager.save_game_in_room(1)
		elif Input.is_key_pressed(KEY_3):
			DataManager.save_game_in_room(2)
		else:
			DataManager.save_game_in_room(0)
		


func load_player_in_starting_room():
	var room = DataManager.current_save.last_room
	if room == null:
		room = SaveData.first_room

	load_room(room)


func spawn_in_current_room():
	var spawn_point = map.get_node_or_null("RoomRespawn")
	if do_respawn and spawn_point:
		player.position = spawn_point.position
		do_respawn = false
