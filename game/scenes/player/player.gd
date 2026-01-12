extends CharacterBody2D
class_name Player
func _process(delta: float) -> void:
	%DebugStateName.visible = debug_mode
func set_animation(animation_name: String):
	$PlayerSprites.play(animation_name)
