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

func test_jump_and_fall():
	runner.simulate_action_press("move_right")
	await runner.await_input_processed()
	await await_millis(500)
	runner.simulate_action_press("jump")
	await runner.await_input_processed()
	await await_millis(500)
	assert_str(player.state_machine.state.name).is_equal(PlayerState.JUMP)
	assert_bool(player.is_on_floor()).is_false()

func test_atack():
	runner.simulate_action_press("move_right")
	await await_millis(300)
	press_and_release("atack")
	await await_millis(200)
	
	assert_str(player.state_machine.state.name).is_equal(PlayerState.ATACK)
	assert_float(player.velocity.x).is_equal(0.0)
	
	await await_millis(500)
	runner.simulate_action_press("jump")
	await runner.await_input_processed()
	runner.simulate_action_press("atack")
	await await_millis(100)
	
	assert_str(player.state_machine.state.name).is_equal(PlayerState.ATACK)
	assert_bool(player.is_on_floor()).is_false()

func press_and_release(action):
	runner.simulate_action_press(action)
	await runner.await_input_processed()
	await await_millis(50)
	runner.simulate_action_release(action)
	await runner.await_input_processed()
