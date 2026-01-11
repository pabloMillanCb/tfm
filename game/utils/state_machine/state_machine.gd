extends Node
class_name StateMachine

@export var initial_state: State = null

@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
).call()


func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)
	
	await owner.ready
	state._enter("")


func _transition_to_next_state(new_state_path: String, init_data := {}):
	if not has_node(new_state_path):
		printerr(owner.name + ": Trying to transition to state " + new_state_path + " but it does not exist.")
		return
	
	var previous_state_path := state.name
	state._exit()
	state = get_node(new_state_path)
	state._enter(previous_state_path, init_data)


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state._update(delta)


func _physics_process(delta: float) -> void:
	state._update_physics(delta)
