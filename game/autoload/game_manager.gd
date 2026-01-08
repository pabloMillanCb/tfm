extends Node

var game: Game

func start_new_game():
	game.set_state(game.GameState.GAME_INTRO)

func load_game():
	game.set_state(game.GameState.GAME_WORLD)

func on_game_intro_finish():
	game.set_state(game.GameState.GAME_WORLD)

func on_game_completed():
	game.set_state(game.GameState.GAME_ENDING)
	
func on_game_ending_finish():
	game.set_state(game.GameState.TITLE_SCREEN)

func pause_game():
	game.set_state(game.GameState.PAUSE_MENU)

func unpause_game():
	game.set_state(game.GameState.GAME_WORLD)

func go_to_title_screen():
	game.set_state(game.GameState.TITLE_SCREEN)

func enter_game_over():
	game.set_state(game.GameState.GAME_OVER)

func respawn_player():
	game.set_state(game.GameState.GAME_WORLD)
