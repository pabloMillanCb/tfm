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

func set_state(new_state: GameState):
	var old_state = current_state
	
	if (new_state == GameState.GAME_WORLD):
		var allowed_states: Array = [GameState.TITLE_SCREEN, 
		GameState.PAUSE_MENU, 
		GameState.GAME_OVER, 
		GameState.GAME_INTRO]
		
		if (allowed_states.has(old_state)):
			exit_state(old_state)
			enter_state(new_state)
		else:
			print_state_change_error(new_state, old_state)
			
	elif (new_state == GameState.GAME_INTRO):
		if (old_state == GameState.TITLE_SCREEN):
			exit_state(old_state)
			enter_state(new_state)
		else:
			print_state_change_error(new_state, old_state)
		
	elif (new_state == GameState.GAME_OVER):
		if (old_state == GameState.GAME_WORLD):
			exit_state(old_state)
			enter_state(new_state)
		else:
			print_state_change_error(new_state, old_state)
		
	elif (new_state == GameState.PAUSE_MENU):
		if (old_state == GameState.GAME_WORLD):
			exit_state(old_state)
			enter_state(new_state)
		else:
			print_state_change_error(new_state, old_state)
		
	elif (new_state == GameState.GAME_ENDING):
		if (old_state == GameState.GAME_WORLD):
			exit_state(old_state)
			enter_state(new_state)
		else:
			print_state_change_error(new_state, old_state)
		
	elif (new_state == GameState.TITLE_SCREEN):
		var allowed_states: Array = [GameState.PAUSE_MENU, GameState.GAME_ENDING]
		if (allowed_states.has(old_state)):
			exit_state(old_state)
			enter_state(new_state)
		else:
			print_state_change_error(new_state, old_state)

func enter_state(new_state: GameState):
	
	if (new_state == GameState.GAME_WORLD):
		$NewState.text = "GameState.GAME_WORLD"
		
	elif (new_state == GameState.GAME_INTRO):
		$NewState.text = "GameState.GAME_INTRO"
		
	elif (new_state == GameState.GAME_OVER):
		$NewState.text = "GameState.GAME_OVER"
		
	elif (new_state == GameState.PAUSE_MENU):
		$NewState.text = "GameState.PAUSE_MENU"
		
	elif (new_state == GameState.GAME_ENDING):
		$NewState.text = "GameState.GAME_ENDING"
		
	elif (new_state == GameState.TITLE_SCREEN):
		$NewState.text = "GameState.TITLE_SCREEN"
		
	current_state = new_state

func exit_state(old_state: GameState):
	
	if (old_state == GameState.GAME_WORLD):
		$OldState.text = "GameState.GAME_WORLD"
		
	elif (old_state == GameState.GAME_INTRO):
		$OldState.text = "GameState.GAME_INTRO"
		
	elif (old_state == GameState.GAME_OVER):
		$OldState.text = "GameState.GAME_OVER"
		
	elif (old_state == GameState.PAUSE_MENU):
		$OldState.text = "GameState.PAUSE_MENU"
		
	elif (old_state == GameState.GAME_ENDING):
		$OldState.text = "GameState.GAME_ENDING"
		
	elif (old_state == GameState.TITLE_SCREEN):
		$OldState.text = "GameState.TITLE_SCREEN"

func print_state_change_error(new_state: GameState, old_state: GameState):
	print("!!! game.tscn ERROR: try entering {new_state} from {old_state}".format({"old_state": GameState.keys()[old_state], "new_state": GameState.keys()[new_state]}))

func _process(delta: float) -> void:
	
	#TODO: test utility, to delete
	
	if (Input.is_action_just_pressed("debug_1")):
		set_state(GameState.TITLE_SCREEN)
	elif (Input.is_action_just_pressed("debug_2")):
		set_state(GameState.GAME_WORLD)
	elif (Input.is_action_just_pressed("debug_3")):
		set_state(GameState.PAUSE_MENU)
	elif (Input.is_action_just_pressed("debug_4")):
		set_state(GameState.GAME_OVER)
	elif (Input.is_action_just_pressed("debug_5")):
		set_state(GameState.GAME_INTRO)
	elif (Input.is_action_just_pressed("debug_6")):
		set_state(GameState.GAME_ENDING)
