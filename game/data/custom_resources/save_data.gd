extends Resource
class_name SaveData

const first_room := "res://scenes/world/rooms/grey_area/GreyRoom3.tscn"
#"res://scenes/world/rooms/grey_area/GreyRoom3.tscn"
#"res://scenes/world/rooms/FirstRoom.tscn"

@export var player_data: PlayerData
@export var last_room: String
@export var play_time: float

@export var metsys_data: Dictionary


func _init(p_player_data: PlayerData = PlayerData.new(), 
		p_last_room = first_room, p_play_time = 0.0, p_metsys_data = {}) -> void:
	player_data = p_player_data
	last_room = p_last_room
	play_time = p_play_time
	metsys_data = p_metsys_data
