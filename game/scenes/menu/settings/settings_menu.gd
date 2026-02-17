extends Node2D
class_name SettingsMenu

signal exited

func _ready() -> void:
	# Languages
	$CenterContainer/VBoxContainer/Back.grab_focus()
	for lang in LocalizationManager.Language.values():
		%LanguageSelection.add_item(LocalizationManager.language_name.get(lang), lang) 
	%LanguageSelection.select(LocalizationManager.get_current_language_index())
	
	# Screen
	%FullscreenCheckbox.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	%BrightnessSlider.value = SettingsManager.settings.screen_brightness
	%ContrastSlider.value = SettingsManager.settings.screen_contrast
	
	# Music
	%MasterVolSlider.value = SettingsManager.settings.master_volume
	%MusicVolSlider.value = SettingsManager.settings.music_volume
	%SfxVolSlider.value = SettingsManager.settings.sfx_volume


func _on_back_pressed() -> void:
	exited.emit()


func _on_option_button_item_selected(index: int) -> void:
	LocalizationManager.set_lang(index)
	SettingsManager.save_data()


func _on_fullscreen_checkbox_toggled(toggled_on: bool) -> void:
	SettingsManager.set_full_screen(toggled_on)


func _on_master_vol_slider_value_changed(value: float) -> void:
	SettingsManager.set_master_volume(value)


func _on_music_vol_slider_value_changed(value: float) -> void:
	SettingsManager.set_music_volume(value)


func _on_sfx_vol_slider_value_changed(value: float) -> void:
	SettingsManager.set_sfx_volume(value)


func _on_brightness_slider_value_changed(value: float) -> void:
	SettingsManager.set_brightness(value)


func _on_contrast_slider_value_changed(value: float) -> void:
	SettingsManager.set_contrast(value)
