extends Node

var current_save := SaveData.new()

const total_save_slots = 3
const save_files_route = "user://"
const save_files_name = "save_slot_%s"

func _ready() -> void:
	GameEvent._on_new_game_start.connect(_reset_current_save)


func save_game_in_room(slot: int) -> bool:
	var room_id = MetSys.get_current_room_id()
	var room_path = ResourceUID.path_to_uid(room_id)
	print(room_path)
	var new_save = current_save
	new_save.last_room = room_path
	var success = save_game_data(slot, new_save)
	
	if success:
		current_save = new_save
		return true
	else:
		return false


func save_game_data(slot: int, save_data: SaveData) -> bool:
	print("game saved")
	if slot >= 0 and slot <= 3:
		var save = ResourceSaver.save(save_data, _get_save_path(slot))
		return save == OK
	else:
		return true


func does_game_data_exist(slot: int) -> bool:
	return ResourceLoader.load(_get_save_path(slot), "", ResourceLoader.CACHE_MODE_IGNORE) != null


func load_game_data(slot: int) -> bool:
	var save = ResourceLoader.load(_get_save_path(slot), "", ResourceLoader.CACHE_MODE_IGNORE)
	if save != null:
		current_save = save
		return true
	else:
		return false


func get_game_data(slot: int) -> SaveData:
	return load(_get_save_path(slot))


func _get_save_path(slot: int) -> String:
	return save_files_route + save_files_name % str(slot) + ".tres"


func _reset_current_save():
	current_save = SaveData.new()
