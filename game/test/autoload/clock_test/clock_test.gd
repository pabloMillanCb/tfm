extends GdUnitTestSuite

var scene = "res://test/autoload/clock_test/ClockTest.tscn"
var runner: GdUnitSceneRunner

func before_test() -> void:
	runner = scene_runner(scene)
	InputMapper.restore_default_controls()
	Clock.stop_clock()

func test_clock_pause_and_resume():
	Clock.start_clock()
	await await_millis(110)
	assert_float(Clock.current_time_count).is_greater(0.100)
	assert_float(Clock.current_time_count).is_less(0.200)
	Clock.pause_clock()
	await await_millis(110)
	assert_float(Clock.current_time_count).is_less(0.200)
	Clock.resume_clock()
	await await_millis(110)
	assert_float(Clock.current_time_count).is_greater(0.200)

func test_clock_stop_and_reset():
	Clock.start_clock()
	await await_millis(110)
	Clock.stop_clock()
	assert_float(Clock.current_time_count).is_equal(0.0)
	Clock.start_clock()
	await await_millis(110)
	Clock.reset_clock()
	await await_millis(110)
	assert_float(Clock.current_time_count).is_greater(0.1)
