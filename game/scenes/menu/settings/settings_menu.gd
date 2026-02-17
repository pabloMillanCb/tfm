extends Node2D
class_name SettingsMenu

signal exited

func _ready() -> void:
	$CenterContainer/VBoxContainer/Back.grab_focus()
	for lang in LocalizationManager.Language.values():
		%LanguageSelection.add_item(LocalizationManager.language_name.get(lang), lang) 
	%LanguageSelection.select(LocalizationManager.get_current_language_index())


func _on_back_pressed() -> void:
	exited.emit()


func _on_option_button_item_selected(index: int) -> void:
	LocalizationManager.set_lang(index)


func _on_fullscreen_checkbox_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
