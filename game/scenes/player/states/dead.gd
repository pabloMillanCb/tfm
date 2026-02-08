extends PlayerState

signal show_death_particles

func _enter(_previous_state_path: String, _init_data := {}):
	player.set_sprite_visibility(false)
	show_death_particles.emit(player.get_look_direction())
	get_tree().create_timer(4.0).timeout.connect(func():
		GameEvent._on_game_over.emit()
	)

func _exit():
	player.set_sprite_visibility(false)
