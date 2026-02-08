extends Node

var current_time_count = 0.0
var is_clock_active = false

func _ready() -> void:
	GameEvent._on_return_to_title_screen.connect(stop_clock)
	GameEvent._on_game_intro_finished.connect(start_clock)
	GameEvent._on_game_load.connect(start_clock)
	GameEvent._on_game_paused.connect(pause_clock)
	GameEvent._on_game_resumed.connect(resume_clock)
	GameEvent._on_game_saved.connect(reset_clock)


func _process(delta: float) -> void:
	if is_clock_active:
		current_time_count += delta


func start_clock():
	is_clock_active = true
	current_time_count = 0.0
	
	
func resume_clock():
	is_clock_active = true
	
	
func pause_clock():
	is_clock_active = false
	
	
func stop_clock():
	is_clock_active = false
	current_time_count = 0.0
	
	
func reset_clock():
	current_time_count = 0.0
