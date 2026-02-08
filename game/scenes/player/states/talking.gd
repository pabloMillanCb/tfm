extends PlayerState

func _enter(_previous_state_path: String, _init_data := {}):
	player.velocity.x = 0.0
	
	var dialogue: DialogueComponent = _init_data.get("dialogue")
	dialogue.show_dialog()
	
	DialogueManager.dialogue_ended.connect(func(_resource): 
		await get_tree().create_timer(0.1).timeout
		print("dialogue finished")
		finished.emit(IDLE))

func _update(_delta):
	player.move_and_slide()
