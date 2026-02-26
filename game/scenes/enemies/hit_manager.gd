extends Node2D

@export var enemy_body: Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("aim_down"):
		print("animate")
		animate_hit()

func animate_hit():
	var tween = get_tree().create_tween()
	tween.tween_property(enemy_body, "scale", Vector2(1.0, 1.0), 1.0)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.play()
