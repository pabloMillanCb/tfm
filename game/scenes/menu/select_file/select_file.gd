extends Node2D
class_name ContinueMenu

@onready var file_card: SaveFileCard = %SaveFileCard

var load_game = false

signal exited

func _ready() -> void:
	
	%Slot1.focus_entered.connect(func():
		update_file_data(0)
	)
	%Slot1.pressed.connect(func():
			select_file(0)
	)
		
	%Slot2.focus_entered.connect(func():
		update_file_data(1)
	)
	%Slot2.pressed.connect(func():
			select_file(1)
	)
	
	%Slot3.focus_entered.connect(func():
		update_file_data(2)
	)
	%Slot3.pressed.connect(func():
			select_file(2)
	)
	
	%Slot1.grab_focus()


func select_file(slot:int):
	if load_game:
		load_save_file(slot)
	else:
		start_new_game(slot)


func load_save_file(slot: int):
	if DataManager.does_game_data_exist(slot):
				DataManager.load_game_data(slot)
				GameEvent._on_game_load.emit()


func start_new_game(slot: int):
	pass


func update_file_data(slot: int):
	if DataManager.does_game_data_exist(slot):
		file_card.set_data(DataManager.get_game_data(slot), slot)
	else:
		file_card.set_data(null, slot)


func _on_back_pressed() -> void:
	exited.emit()


func _on_slot_1_pressed() -> void:
	pass # Replace with function body.
