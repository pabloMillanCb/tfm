extends Enemy
class_name Piranha

@export var speed = 30.0
@onready var point_a = $StartPoint.global_position
@onready var point_b = $EndPoint.global_position
var going_backwards = false

func _ready() -> void:
	if going_backwards:
		point_a = $EndPoint.global_position
		point_b = $StartPoint.global_position
		
	global_position = point_a
	
func _process(delta: float) -> void:
	
	$AnimatedSprite2D.material.set_shader_parameter("time", $InvencibleTimer.time_left)
	
	var previous_position = global_position
	
	if going_backwards:
		global_position = global_position.move_toward(point_a, delta * speed)
		if global_position == point_a:
			going_backwards = !going_backwards
	else:
		global_position = global_position.move_toward(point_b, delta * speed)
		if global_position == point_b:
			going_backwards = !going_backwards
	
	$AnimatedSprite2D.flip_h = (previous_position - global_position).x > 0


func take_damage(direction: Vector2 = Vector2.ZERO):
	going_backwards = !going_backwards
	play_hit_animation()
	$InvencibleTimer.start()
	super()
