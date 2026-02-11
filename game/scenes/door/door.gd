extends StaticBody2D
class_name Door

@export var key_movement_curve: Curve

var key = null
var pull_key_position = Vector2.ZERO

func _ready() -> void:
	MetSys.register_storable_object(self)


func _on_key_detected(area: Area2D) -> void:
	key = area
	var direction_to_key =  global_position.direction_to(key.global_position)
	const PULL_KEY_DISTANCE = 30
	pull_key_position = (key.global_position 
		+ direction_to_key 
		* PULL_KEY_DISTANCE
		+ Vector2(0.0, -32.0))
	GameEvent.key_used.emit()
	create_push_tween()
	$Area2D.area_entered.disconnect(_on_key_detected)


func create_push_tween():
	var push_tween = get_tree().create_tween()
	push_tween.set_ease(Tween.EASE_IN_OUT)
	push_tween.set_trans(Tween.TRANS_CUBIC)
	push_tween.tween_property(key, "global_position", pull_key_position, 0.8)
	push_tween.tween_callback(create_pull_tween)
	
	push_tween.play()


func create_pull_tween():
	
	#await get_tree().create_timer(0.2).timeout
	
	var pull_tween = get_tree().create_tween()
	pull_tween.set_ease(Tween.EASE_IN)
	pull_tween.set_trans(Tween.TRANS_CUBIC)
	pull_tween.tween_property(key, "global_position", global_position, 0.4)
	pull_tween.tween_callback(unlock_door)
	
	pull_tween.play()


func unlock_door():
	#key animation
	#door unlock animation
	MetSys.store_object(self)
	key.use()
	$AnimationPlayer.play("open")
	await $AnimationPlayer.animation_finished
	queue_free()
	#wait
