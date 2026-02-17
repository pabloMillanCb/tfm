extends Node

enum Language {ENGLISH, SPANISH}

var language_code = { Language.ENGLISH: "en", Language.SPANISH: "es"}
var language_name = { Language.ENGLISH: "English", Language.SPANISH: "Español"}

@onready var game_settings: SettingsData = preload("res://assets/resources/game_settings.tres")
@onready var current_language = get_default_language.call()

func get_default_language():
	
	if game_settings != null and !game_settings.language.is_empty():
		return game_settings.language
	elif language_code.has(TranslationServer.get_locale()):
		game_settings.language = TranslationServer.get_locale()
		game_settings.save_data()
		return game_settings.language
	else:
		game_settings.language = language_code.get(Language.ENGLISH) 
		game_settings.save_data()
		return game_settings.language


func set_lang(language: Language):
	var new_language = language_code.get(language)
	if new_language != null:
		current_language = new_language
		game_settings.language = current_language
		game_settings.save_data()
		TranslationServer.set_locale(current_language)


func get_current_language_name():
	return language_name.get(current_language)
	

func get_current_language_index():
	return language_code.find_key(current_language)
