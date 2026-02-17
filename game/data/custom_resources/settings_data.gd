extends Resource
class_name SettingsData

@export var language: LocalizationManager.Language
@export var full_screen_enable: bool
@export var master_volume: float
@export var music_volume: float
@export var sfx_volume: float
@export var screen_brightness: float
@export var screen_contrast: float

#Controls is managed in input_mapper.gd
func _init() -> void:
	#language = LocalizationManager.Language.ENGLISH
	full_screen_enable = false
	master_volume = 0.8
	music_volume = 0.8
	sfx_volume = 0.8
	screen_brightness = 1.0
	screen_contrast = 1.0
