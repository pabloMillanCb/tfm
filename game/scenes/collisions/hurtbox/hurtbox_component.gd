extends Area2D
class_name HurtboxComponent

func _ready() -> void:
	area_entered.connect(_on_atack_detected)


func _on_atack_detected(area: HitboxComponent) -> void:
	if (owner.has_method("take_damage")):
		owner.take_damage()
