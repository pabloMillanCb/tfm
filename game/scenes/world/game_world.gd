extends "res://addons/MetroidvaniaSystem/Template/Scripts/MetSysGame.gd"
class_name GameWorld

var starting_room = "res://scenes/world/rooms/TestScene1.tscn"

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


func load_player_in_starting_room():
	if false: #TODO: if there exists a checkpoint/save
		pass
	else:
		load_room(starting_room)


func spawn_in_current_room():
	var spawn_point = map.get_node_or_null("RoomRespawn")
	if do_respawn and spawn_point:
		player.position = spawn_point.position
		do_respawn = false
