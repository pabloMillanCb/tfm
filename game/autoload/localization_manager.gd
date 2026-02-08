extends Node

enum Language {ENGLISH, SPANISH}

@onready var current_language = (func():
	if language_code.has(TranslationServer.get_locale()):
		return TranslationServer.get_locale()
	else:
		return language_code.get(Language.ENGLISH)
	).call()

var language_code = { Language.ENGLISH: "en", Language.SPANISH: "es"}
var language_name = { Language.ENGLISH: "English", Language.SPANISH: "Español"}


func set_lang(language: Language):
	var new_language = language_code.get(language)
	if new_language != null:
		current_language = new_language
		TranslationServer.set_locale(current_language)


func get_current_language_name():
	return language_name.get(current_language)
	

func get_current_language_index():
	return language_code.find_key(current_language)
