extends Node2D

func _ready() -> void:
	DialogueManager.dialogue_started.connect(func ():
		print("dialogue_started")
		$AudioStreamPlayer.play())
