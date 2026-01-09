extends GdUnitTestSuite

var scene = "res://test/autoload/input_manager_test/TestInputManager.tscn"
var runner: GdUnitSceneRunner

func before_test() -> void:
	runner = scene_runner(scene)

func test_remap_action_key(action: String, original_key: int, test_parameters := [
	["jump", KEY_Z],
	["atack", KEY_X],
	["move_left", KEY_LEFT],
	["move_right", KEY_RIGHT],
	["aim_down", KEY_DOWN],
	["teleport", KEY_SHIFT],
	["pause", KEY_ESCAPE],
	["map", KEY_TAB],
	]):
	
	runner.simulate_key_press(original_key)
	await runner.await_input_processed()
	assert_bool(Input.is_action_pressed(action)).is_true()
	runner.simulate_key_release(original_key)
	await runner.await_input_processed()
	
	InputMapper.listen_for_action_remap(action)
	runner.simulate_key_press(KEY_P)
	runner.simulate_key_release(KEY_P)
	await runner.await_input_processed()
	
	runner.simulate_key_press(KEY_P)
	await runner.await_input_processed()
	assert_bool(Input.is_action_pressed(action)).is_true()
