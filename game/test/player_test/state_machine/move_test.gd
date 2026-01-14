extends GdUnitTestSuite

var scene = "res://test/player_test/PlayerTest.tscn"
var runner: GdUnitSceneRunner
var player: Player

func before_test():
	runner = scene_runner(scene)
	player = runner.find_child("Player")

func test_move_right_and_left():
	
	runner.simulate_action_press("move_right")
	await runner.await_input_processed()
	await await_millis(500)
	assert_float(player.velocity.x).is_greater(0.0)
	assert_str(player.state_machine.state.name).is_equal(PlayerState.MOVE)
	
	runner.simulate_action_release("move_right")
	runner.simulate_action_press("move_left")
	await runner.await_input_processed()
	await await_millis(500)
	assert_float(player.velocity.x).is_less(0.0)
	
	runner.simulate_action_release("move_")
	runner.simulate_action_press("move_left")
	runner.await_input_processed()
