extends Node2D

@onready var input_list = [%Jump, %Atack, %Wand, %Pause,
%Accept, %Back, %Map]

var listening_to_action = false
var last_assigned_button: Button

func _ready() -> void:
	%JumpAssign.grab_focus()
	
	(%JumpAssign as Button).pressed.connect(func(): (select_action_to_remap("jump", %JumpAssign)))
	(%AtackAssign as Button).pressed.connect(func(): (select_action_to_remap("atack", %AtackAssign)))   
	(%WandAssign as Button).pressed.connect(func(): (select_action_to_remap("teleport", %WandAssign)))
	(%PauseAssign as Button).pressed.connect(func(): (select_action_to_remap("pause", %PauseAssign)))
	(%AcceptAssign as Button).pressed.connect(func(): (select_action_to_remap("ui_accept", %AcceptAssign)))
	(%BackAssign as Button).pressed.connect(func(): (select_action_to_remap("ui_cancel", %BackAssign)))
	(%MapAssign as Button).pressed.connect(func(): (select_action_to_remap("map", %MapAssign)))


func _input(event: InputEvent) -> void:
	if event.is_pressed() and listening_to_action:
		listening_to_action = false
		for input in input_list:
			input.modulate.a = 1.0
		ActionIcon.refresh_all()
		await get_tree().create_timer(0.1).timeout
		last_assigned_button.grab_focus()


func select_action_to_remap(action: String, button: Button):
	button.release_focus()
	last_assigned_button = button
	listening_to_action= true
	InputMapper.listen_for_action_remap(action)
	
	for input in input_list:
		if input != last_assigned_button.get_parent():
			input.modulate.a = 0.5


func _on_default_pressed() -> void:
	InputMapper.restore_default_controls()
	ActionIcon.refresh_all()


func _on_go_back_pressed() -> void:
	queue_free()
