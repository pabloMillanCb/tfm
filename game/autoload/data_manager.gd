extends Node

const total_save_slots = 3
const save_files_route = "user://"
const save_files_name = "save_slot_%s"

func save_game_data(slot: int, save_data: SaveData) -> bool:
	if slot >= 0 and slot <= 3:
		var save = ResourceSaver.save(save_data, _get_save_path(slot))
		return save == OK
	else:
		return true


func does_game_data_exist(slot: int) -> bool:
	return load(_get_save_path(slot)) != null


func load_game_data(slot: int) -> SaveData:
	return load(_get_save_path(slot))


func _get_save_path(slot: int) -> String:
	return save_files_route + save_files_name % str(slot) + ".tres"
