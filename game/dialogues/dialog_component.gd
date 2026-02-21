extends Area2D
class_name DialogueComponent

@export var dialog_script = preload("res://dialogues/test_dialog/test_dialogue.dialogue")
@export var dialog_balloon = preload("res://dialogues/balloon.tscn")

var player: Player
var talking = false

func _process(delta: float) -> void:
	$Arrow.visible = player != null and !talking
	
	if Input.is_action_just_pressed("aim_up") and player != null:
		player.dialog_start_request.emit(self)


func show_dialog():
	DialogueManager.show_dialogue_balloon_scene(dialog_balloon, dialog_script)
	talking = true
	DialogueManager.dialogue_ended.connect(func(_resource): 
		talking = false
	)


func _on_body_entered(body: Node2D) -> void:
	player = body


func _on_body_exited(body: Node2D) -> void:
	player = null
