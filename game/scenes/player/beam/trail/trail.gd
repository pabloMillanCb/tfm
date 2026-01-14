extends Line2D

@export var max_length = 30.0

var head_position = global_position

func _ready() -> void:
	points[0].x = global_position.x
	points[1].x = global_position.x

func _process(delta: float) -> void:
	
	points[0] = head_position
	
	if points[0].distance_to(points[1]) > max_length:
		points[1] = points[0] + points[0].direction_to(points[1]) * max_length

func update_position(new_position):
	head_position = new_position
