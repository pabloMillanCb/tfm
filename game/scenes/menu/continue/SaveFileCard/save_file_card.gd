extends Node2D
class_name SaveFileCard
func set_data(data: SaveData, slot: int):
	
	if data != null:
		$FileName.text = "Saved data " + str(slot+1)
		$PlaytimeValue.text = str(data.play_time)
	else:
		$FileName.text = "no data"
		$PlaytimeValue.text = "-"
