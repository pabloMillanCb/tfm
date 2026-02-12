extends Area2D
class_name HurtboxComponent


func _on_atack_detected(area: HitboxComponent) -> void:
	owner.take_damage()
	if (owner.has_method("take_damage")):
		owner.take_damage()
