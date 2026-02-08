extends Node2D
class_name Game

enum GameState {
	TITLE_SCREEN,
	GAME_WORLD,
	PAUSE_MENU,
	GAME_OVER,
	GAME_INTRO,
	GAME_ENDING,
}

var current_state: GameState = GameState.TITLE_SCREEN

func _ready() -> void:
	
	GameEvent._on_return_to_title_screen.connect(func():set_state(GameState.TITLE_SCREEN))
	GameEvent._on_game_load.connect(func():set_state(GameState.GAME_WORLD))
	GameEvent._on_game_paused.connect(func():set_state(GameState.PAUSE_MENU))
	GameEvent._on_game_over.connect(func():set_state(GameState.GAME_OVER))
	GameEvent._on_new_game_start.connect(func():set_state(GameState.GAME_INTRO))
	GameEvent._on_game_completed.connect(func():set_state(GameState.GAME_ENDING))
	GameEvent._on_game_resumed.connect(func(): set_state(GameState.GAME_WORLD))
	GameEvent._on_game_intro_finished.connect(func(): set_state(GameState.GAME_WORLD))
	GameEvent._on_player_respawn.connect(func(): set_state(GameState.GAME_WORLD))
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and current_state == GameState.GAME_WORLD:
		GameEvent._on_game_paused.emit()


func set_state(new_state: GameState):
	var old_state = current_state
	
	if (new_state == GameState.GAME_WORLD):
		var allowed_states: Array = [GameState.TITLE_SCREEN, 
		GameState.PAUSE_MENU, 
		GameState.GAME_OVER, 
		GameState.GAME_INTRO]
		
		if (allowed_states.has(old_state)):
			exit_state(old_state, new_state)
			enter_state(new_state, old_state)
		else:
			print_state_change_error(new_state, old_state)
			
	elif (new_state == GameState.GAME_INTRO):
		if (old_state == GameState.TITLE_SCREEN):
			exit_state(old_state, new_state)
			enter_state(new_state, old_state)
		else:
			print_state_change_error(new_state, old_state)
		
	elif (new_state == GameState.GAME_OVER):
		if (old_state == GameState.GAME_WORLD):
			exit_state(old_state, new_state)
			enter_state(new_state, old_state)
		else:
			print_state_change_error(new_state, old_state)
		
	elif (new_state == GameState.PAUSE_MENU):
		if (old_state == GameState.GAME_WORLD):
			exit_state(old_state, new_state)
			enter_state(new_state, old_state)
		else:
			print_state_change_error(new_state, old_state)
		
	elif (new_state == GameState.GAME_ENDING):
		if (old_state == GameState.GAME_WORLD):
			exit_state(old_state, new_state)
			enter_state(new_state, old_state)
		else:
			print_state_change_error(new_state, old_state)
		
	elif (new_state == GameState.TITLE_SCREEN):
		var allowed_states: Array = [GameState.PAUSE_MENU, GameState.GAME_ENDING, GameState.GAME_OVER]
		if (allowed_states.has(old_state)):
			exit_state(old_state, new_state)
			enter_state(new_state, old_state)
		else:
			print_state_change_error(new_state, old_state)

func enter_state(new_state: GameState, old_state: GameState):
	
	print("Entering {new_state} from {old_state}".format({"old_state": GameState.keys()[old_state], "new_state": GameState.keys()[new_state]}))
	
	if (new_state == GameState.GAME_WORLD):
		$NewState.text = "GameState.GAME_WORLD"
		if old_state != GameState.PAUSE_MENU:
			add_child(preload("res://scenes/world/GameWorld.tscn").instantiate())
		%Minimap.visible = true
		
	elif (new_state == GameState.GAME_INTRO):
		$NewState.text = "GameState.GAME_INTRO"
		add_child(preload("res://scenes/cutscenes/intro/GameIntro.tscn").instantiate())
		
	elif (new_state == GameState.GAME_OVER):
		$NewState.text = "GameState.GAME_OVER"
		add_child(preload("res://scenes/menu/game_over/GameOver.tscn").instantiate())
		
	elif (new_state == GameState.PAUSE_MENU):
		$NewState.text = "GameState.PAUSE_MENU"
		add_child(preload("res://scenes/menu/pause/pause_menu.tscn").instantiate())
		get_tree().paused = true
		
	elif (new_state == GameState.GAME_ENDING):
		$NewState.text = "GameState.GAME_ENDING"
		
	elif (new_state == GameState.TITLE_SCREEN):
		$NewState.text = "GameState.TITLE_SCREEN"
		add_child(preload("res://scenes/menu/main/MainMenu.tscn").instantiate())
		
	current_state = new_state

func exit_state(old_state: GameState, new_state: GameState):
	
	if (old_state == GameState.GAME_WORLD):
		$OldState.text = "GameState.GAME_WORLD"
		if new_state != GameState.PAUSE_MENU:
			get_node("GameWorld").queue_free()
		%Minimap.visible = false
		
	elif (old_state == GameState.GAME_INTRO):
		$OldState.text = "GameState.GAME_INTRO"
		get_node("GameIntro").queue_free()
		
	elif (old_state == GameState.GAME_OVER):
		$OldState.text = "GameState.GAME_OVER"
		get_node("GameOver").queue_free()
		
	elif (old_state == GameState.PAUSE_MENU):
		$OldState.text = "GameState.PAUSE_MENU"
		get_node("PauseMenu").queue_free()
		if new_state == GameState.TITLE_SCREEN:
			get_node("GameWorld").queue_free()
		get_tree().paused = false
		
	elif (old_state == GameState.GAME_ENDING):
		$OldState.text = "GameState.GAME_ENDING"
		
	elif (old_state == GameState.TITLE_SCREEN):
		$OldState.text = "GameState.TITLE_SCREEN"
		get_node("MainMenu").queue_free()

func print_state_change_error(new_state: GameState, old_state: GameState):
	print("!!! game.tscn ERROR: try entering {new_state} from {old_state}".format({"old_state": GameState.keys()[old_state], "new_state": GameState.keys()[new_state]}))

func _process(delta: float) -> void:
	
	#TODO: test utility, to delete
	
	if (Input.is_action_just_pressed("debug_1")):
		GameEvent._on_return_to_title_screen.emit() #
	elif (Input.is_action_just_pressed("debug_2")):
		GameEvent._on_game_load.emit() #
	elif (Input.is_action_just_pressed("debug_3")):
		GameEvent._on_game_paused.emit() #
	elif (Input.is_action_just_pressed("debug_4")):
		GameEvent._on_game_over.emit() #
	elif (Input.is_action_just_pressed("debug_5")):
		GameEvent._on_new_game_start.emit() #
	elif (Input.is_action_just_pressed("debug_6")):
		GameEvent._on_game_completed.emit() #
