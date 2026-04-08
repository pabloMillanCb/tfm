extends Node

enum Language {ENGLISH, SPANISH}

var language_code = { Language.ENGLISH: "en", Language.SPANISH: "es"}
var language_name = { Language.ENGLISH: "English", Language.SPANISH: "Español"}
var language_value = { "en": Language.ENGLISH, "es":  Language.SPANISH}

@onready var game_settings: SettingsData = preload("res://assets/resources/game_settings.tres")

func _ready() -> void:
	get_default_language()

func get_default_language():
	
	if game_settings.language != null:
		TranslationServer.set_locale(language_code.get(game_settings.language))
		return game_settings.language
	elif language_code.has(TranslationServer.get_locale()):
		game_settings.language = language_value.get(TranslationServer.get_locale())
		game_settings.save_data()
		TranslationServer.set_locale(language_code.get(game_settings.language))
		return game_settings.language
	else:
		game_settings.language = language_code.get(Language.ENGLISH) 
		game_settings.save_data()
		TranslationServer.set_locale(language_code.get(game_settings.language))
		return game_settings.language


func set_lang(language: Language):
	var new_language = language_code.get(language)
	if new_language != null:
		game_settings.language = language
		TranslationServer.set_locale(new_language)


func get_current_language_name():
	return language_name.get(game_settings.language)
	

func get_current_language_index():
	return game_settings.language
