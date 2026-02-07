extends PlayerState

signal show_death_particles

func _enter(_previous_state_path: String, _init_data := {}):
	player.set_sprite_visibility(false)
	show_death_particles.emit(player.get_look_direction())

func _exit():
	player.set_sprite_visibility(false)
