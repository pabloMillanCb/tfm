extends Node

var input_maping: ControlsRemap
var action_to_remap = ""

const REMAP_FILE_LOCATION = "user://my_control_remap.tres"


func _ready() -> void:
	input_maping = load(REMAP_FILE_LOCATION)
	
	if input_maping != null:
		input_maping.apply_remap()
	else:
		input_maping = ControlsRemap.new()


func _input(event):
	if event is InputEventKey and not action_to_remap.is_empty():
		input_maping.set_action_key(action_to_remap, event)
		input_maping.create_remap()
		ResourceSaver.save(input_maping, REMAP_FILE_LOCATION)
		action_to_remap = ""


func listen_for_action_remap(action: String):
	if input_maping.action_list.has(StringName(action)):
		action_to_remap = action


func remap_action(action: String, input: InputEvent):
	input_maping.set_action_key(action, input)


func save_remap_changes():
	input_maping.create_remap()


func get_action_list():
	return input_maping.action_list

func restore_default_controls():
	input_maping.restore_default_controls()
