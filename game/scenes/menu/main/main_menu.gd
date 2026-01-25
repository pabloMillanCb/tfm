extends Node2D


func _ready() -> void:
	$CenterContainer/VBoxContainer/New.grab_focus()


func _on_new_pressed() -> void:
	GameEvent._on_new_game_start.emit()


func _on_load_pressed() -> void:
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	var settings_menu: SettingsMenu = preload("res://scenes/menu/settings/SettingsMenu.tscn").instantiate()
	add_child(settings_menu)
	$CenterContainer/VBoxContainer/Settings.release_focus()
	$CenterContainer.visible = false
	
	settings_menu.exited.connect(func (): 
		get_node("SettingsMenu").queue_free()
		$CenterContainer/VBoxContainer/Settings.grab_focus()
		$CenterContainer.visible = true
	)


func _on_exit_pressed() -> void:
	pass # Replace with function body.
