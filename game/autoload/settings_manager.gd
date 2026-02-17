extends Node

var master_bus_index = AudioServer.get_bus_index("Master")
var music_bus_index = AudioServer.get_bus_index("Music")
var sfx_bus_index = AudioServer.get_bus_index("SFX")

@onready var settings: SettingsData = preload("res://assets/resources/game_settings.tres")

func _ready() -> void:
	apply_settings()


func save_data():
	ResourceSaver.save(settings, "res://assets/resources/game_settings.tres")


func apply_settings():
	
	# Languages
	#LocalizationManager.set_lang(settings.language)
	
	# Fullscreen
	if settings.full_screen_enable:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		
	# Audio
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(settings.master_volume))
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(settings.music_volume))
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(settings.sfx_volume))
	
	# Screen
	ScreenEnvironment.set_brightnes(settings.screen_brightness)
	ScreenEnvironment.set_contrast(settings.screen_contrast)
	
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
