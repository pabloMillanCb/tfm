extends TriangleFishState


var push_direction: Vector2

func _enter(_previous_state_path: String, _init_data := {}):
	
	fish.health -= 1
	
	if fish.health == 0:
		finished.emit(DEAD)
		return
	
	fish.can_take_hits = false
	
	push_direction = _init_data.get("push_direction", Vector2.ZERO)
	
	const PUSH_FORCE = 50
	fish.velocity.x = PUSH_FORCE * push_direction.x
	fish.velocity.y = 0
	
	$Timer.start()


func _exit():
	fish.can_take_hits = true


func _update_physics(_delta):
	fish.move_and_slide()


func _on_timer_timeout() -> void:
	finished.emit(CHASE)
