extends Area2D
class_name Beam

const BULLET_SPEED = 350

var direction = 1

func _ready() -> void:
	$Trail.set_initial_position(global_position)
	

func _process(delta: float) -> void:
	position.x += direction * BULLET_SPEED * delta
	$Trail.update_position(global_position)


func hit_objective():
	$Trail.going_forward = false
	$Trail.trail_ended.connect(explode)

func explode():
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	hit_objective()


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	hit_objective()


func _on_timer_timeout() -> void:
	hit_objective()
