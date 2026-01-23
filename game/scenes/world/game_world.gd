extends "res://addons/MetroidvaniaSystem/Template/Scripts/MetSysGame.gd"
class_name GameWorld

var starting_room = "res://scenes/world/rooms/TestScene1.tscn"

func _ready() -> void:
	MetSys.reset_state()
	MetSys.set_save_data()
	set_player($Player)
	$Player.global_position += Vector2(100, 100)
	load_player_in_starting_room()
	add_module("RoomTransitions.gd")
	init_room()

func _process(delta: float) -> void:
	MetSys.get_current_room_instance().adjust_camera_limits($Player/Camera2D)

func load_player_in_starting_room():
	if false: #if there exists a checkpoint/save
		pass
	else:
		load_room(starting_room)

func init_room():
	MetSys.get_current_room_instance().adjust_camera_limits($Player/Camera2D)
