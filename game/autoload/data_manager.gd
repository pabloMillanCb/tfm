extends Node

var current_save := SaveData.new()
var current_slot := 0

const total_save_slots = 3
const save_files_route = "user://"
const save_files_name = "save_slot_%s"


func save_game_in_room(player_data: PlayerData) -> bool:
	var room_id = MetSys.get_current_room_id()
	var room_path = ResourceUID.path_to_uid(room_id)

	var new_save = current_save
	
	new_save.player_data = player_data
	new_save.last_room = room_path
	new_save.play_time += Clock.current_time_count
	new_save.metsys_data = MetSys.get_save_data()
	
	var success = save_game_data(current_slot, new_save)
	
	if success:
		current_save = new_save
		GameEvent._on_game_saved.emit()
		return true
	else:
		return false


func save_game_data(slot: int, save_data: SaveData) -> bool:
	if slot >= 0 and slot <= 3:
		var save = ResourceSaver.save(save_data, _get_save_path(slot))
		return save == OK
	else:
		return true


func does_game_data_exist(slot: int) -> bool:
	return ResourceLoader.load(_get_save_path(slot), "", ResourceLoader.CACHE_MODE_IGNORE) != null


func start_new_game(slot: int):
	var save = SaveData.new()
	if save != null:
		current_save = save
		current_slot = slot
		return true
	else:
		return false


func load_game_data(slot: int) -> bool:
	var save = ResourceLoader.load(_get_save_path(slot), "", ResourceLoader.CACHE_MODE_IGNORE)
	if save != null:
		current_save = save
		current_slot = slot
		return true
	else:
		return false


func get_game_data(slot: int) -> SaveData:
	return load(_get_save_path(slot))


func _get_save_path(slot: int) -> String:
	return save_files_route + save_files_name % str(slot) + ".tres"


func delete_data_from_slot(slot: int):
	DirAccess.remove_absolute(_get_save_path(slot))


func delete_all_data():
	delete_data_from_slot(0)
	delete_data_from_slot(1)
	delete_data_from_slot(2)
