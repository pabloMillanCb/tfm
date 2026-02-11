extends Node


# Signals related to global game states

signal _on_new_game_start

signal _on_game_load
	
signal _on_game_intro_finished
	
signal _on_game_completed
	
signal _on_game_ending_finished
	
signal _on_game_paused
	
signal _on_game_resumed
	
signal _on_return_to_title_screen
	
signal _on_game_over
	
signal _on_player_respawn

signal _on_game_saved


# Pick ups
signal key_picked_up(key: DoorKey, player: Player)

signal key_used
