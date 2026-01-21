extends GdUnitTestSuite

var scene = "res://test/game_test/GameTest.tscn"
var runner: GdUnitSceneRunner
var game: Game

func simulate_single_action_press(action: String):
	runner.simulate_action_press(action)
	await runner.await_input_processed()
	runner.simulate_action_release(action)
	await runner.await_input_processed()

func before_test() -> void:
	runner = scene_runner(scene)
	game = runner.find_child("Game")

func after() -> void:
	get_tree().paused = false

func test_starting_state():
	
	assert_int(game.current_state).is_equal(game.GameState.TITLE_SCREEN)
	
func test_start_new_game():
	
	await simulate_single_action_press("debug_5")
	assert_int(game.current_state).is_equal(game.GameState.GAME_INTRO)
	
	await simulate_single_action_press("debug_2")
	assert_int(game.current_state).is_equal(game.GameState.GAME_WORLD)

func test_load_game_and_pause_game():
	
	await simulate_single_action_press("debug_2")
	assert_int(game.current_state).is_equal(game.GameState.GAME_WORLD)
	
	await simulate_single_action_press("pause")
	assert_int(game.current_state).is_equal(game.GameState.PAUSE_MENU)
	
	await simulate_single_action_press("ui_accept")
	assert_int(game.current_state).is_equal(game.GameState.GAME_WORLD)
	
func test_return_to_title_screen():
	
	await simulate_single_action_press("debug_2")
	assert_int(game.current_state).is_equal(game.GameState.GAME_WORLD)
	
	await simulate_single_action_press("pause")
	assert_int(game.current_state).is_equal(game.GameState.PAUSE_MENU)
	
	await simulate_single_action_press("ui_down")
	await simulate_single_action_press("ui_down")
	await simulate_single_action_press("ui_accept")
	assert_int(game.current_state).is_equal(game.GameState.TITLE_SCREEN)

func test_load_game_die_and_respawn():
	
	await simulate_single_action_press("debug_2")
	assert_int(game.current_state).is_equal(game.GameState.GAME_WORLD)
	
	await simulate_single_action_press("debug_4")
	assert_int(game.current_state).is_equal(game.GameState.GAME_OVER)
	
	await simulate_single_action_press("debug_2")
	assert_int(game.current_state).is_equal(game.GameState.GAME_WORLD)
	
func test_load_game_finish_game_and_return_to_title():
	
	await simulate_single_action_press("debug_2")
	assert_int(game.current_state).is_equal(game.GameState.GAME_WORLD)
	
	await simulate_single_action_press("debug_6")
	assert_int(game.current_state).is_equal(game.GameState.GAME_ENDING)
	
	await simulate_single_action_press("debug_1")
	assert_int(game.current_state).is_equal(game.GameState.TITLE_SCREEN)

func test_forbidden_game_state_changes():
	
	await simulate_single_action_press("debug_6")
	assert_int(game.current_state).is_equal(game.GameState.TITLE_SCREEN)
	
	await simulate_single_action_press("debug_5")
	await simulate_single_action_press("debug_1")
	assert_int(game.current_state).is_equal(game.GameState.GAME_INTRO)
	
	await simulate_single_action_press("debug_2")
	await simulate_single_action_press("debug_1")
	await simulate_single_action_press("debug_5")
	assert_int(game.current_state).is_equal(game.GameState.GAME_WORLD)
	
	await simulate_single_action_press("debug_4")
	await simulate_single_action_press("debug_3")
	await simulate_single_action_press("debug_6")
	await simulate_single_action_press("debug_5")
	await simulate_single_action_press("debug_1")
	assert_int(game.current_state).is_equal(game.GameState.GAME_OVER)
	
	await simulate_single_action_press("debug_2")
	await simulate_single_action_press("debug_3")
	await simulate_single_action_press("debug_4")
	await simulate_single_action_press("debug_5")
	await simulate_single_action_press("debug_6")
	assert_int(game.current_state).is_equal(game.GameState.PAUSE_MENU)
	
	await simulate_single_action_press("ui_accept")
	assert_int(game.current_state).is_equal(game.GameState.GAME_WORLD)
