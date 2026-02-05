extends Resource
class_name SaveData

const first_room := ""

var player_data: PlayerData
var last_room: String
var play_time: float


func _init(p_player_data: PlayerData, p_last_room = first_room, p_play_time = 0.0) -> void:
	player_data = p_player_data
	last_room = p_last_room
	play_time = p_play_time
