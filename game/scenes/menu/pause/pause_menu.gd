extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/VBoxContainer/Resume.grab_focus()
	$Timer.start()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("pause"):
		if $Timer.time_left == 0:
			_on_resume_pressed()

func _on_resume_pressed() -> void:
	GameEvent._on_game_resumed.emit()


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


func _on_main_menu_pressed() -> void:
	GameEvent._on_return_to_title_screen.emit()
