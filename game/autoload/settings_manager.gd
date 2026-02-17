extends Node

@onready var settings: SettingsData = preload("res://assets/resources/game_settings.tres")


func save_data():
	ResourceSaver.save(settings, "res://assets/resources/game_settings.tres")


func apply_settings():
	# function body
	save_data()


func set_language(language: LocalizationManager.Language):
	LocalizationManager.set_lang(language)
	apply_settings()


func set_full_screen(enabled: bool):
	settings.full_screen_enable = enabled
	apply_settings()


func set_master_volume(volume: float):
	settings.master_volume = volume
	apply_settings()


func set_music_volume(volume: float):
	settings.music_volume = volume
	apply_settings()
	
	
func set_sfx_volume(volume: float):
	settings.sfx_volume_volume = volume
	apply_settings()


func set_brightness(value: float):
	const MIN_BRIGHTNESS = 0.5
	const MAX_BRIGHTNESS = 1.5
	if value >= MIN_BRIGHTNESS and value <= MAX_BRIGHTNESS:
		settings.screen_brightness = value
		apply_settings()


func set_contrast(value: float):
	const MIN_CONTRAST = 0.75
	const MAX_CONTRAST = 1.25
	if value >= MIN_CONTRAST and value <= MAX_CONTRAST:
		settings.screen_contrast = value
		apply_settings()
