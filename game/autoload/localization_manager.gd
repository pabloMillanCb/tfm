extends Node

enum Language {ENGLISH, SPANISH}

var language_code = { Language.ENGLISH: "en", Language.SPANISH: "es"}

func set_lang(language: Language):
	TranslationServer.set_locale(language_code.get(language))
