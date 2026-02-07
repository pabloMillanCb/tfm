extends Node2D
class_name ContinueMenu

@onready var file_card: SaveFileCard = %SaveFileCard

signal exited

func _ready() -> void:
	
	%Slot1.focus_entered.connect(func():
		update_file_data(0)
	)
	%Slot1.pressed.connect(func():
			if DataManager.does_game_data_exist(0):
				DataManager.load_game_data(0)
				GameEvent._on_game_load.emit()
	)
		
	%Slot2.focus_entered.connect(func():
		update_file_data(1)
	)
	%Slot2.pressed.connect(func():
			if DataManager.does_game_data_exist(1):
				DataManager.load_game_data(1)
				GameEvent._on_game_load.emit()
	)
	
	%Slot3.focus_entered.connect(func():
		update_file_data(2)
	)
	%Slot3.pressed.connect(func():
			if DataManager.does_game_data_exist(3):
				DataManager.load_game_data(3)
				GameEvent._on_game_load.emit()
	)
	
	%Slot1.grab_focus()


func update_file_data(slot: int):
	if DataManager.does_game_data_exist(slot):
		file_card.set_data(DataManager.get_game_data(slot), slot)
	else:
		file_card.set_data(null, slot)


func _on_back_pressed() -> void:
	exited.emit()


func _on_slot_1_pressed() -> void:
	pass # Replace with function body.
