extends Node2D
class_name ContinueMenu

@onready var file_card: SaveFileCard = %SaveFileCard

signal exited

func _ready() -> void:
	
	%Slot1.focus_entered.connect(func():
		update_file_data(0)
		)
	%Slot2.focus_entered.connect(func():
		update_file_data(1)
		)
	%Slot3.focus_entered.connect(func():
		update_file_data(2)
		)
	
	%Slot1.grab_focus()


func update_file_data(slot: int):
	if DataManager.does_game_data_exist(slot):
		file_card.set_data(DataManager.load_game_data(slot), slot)
	else:
		file_card.set_data(null, slot)


func _on_back_pressed() -> void:
	exited.emit()
