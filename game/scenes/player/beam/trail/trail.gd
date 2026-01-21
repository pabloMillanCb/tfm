extends Line2D

@export var max_length = 30.0

var head_position = global_position

var going_forward = true
signal trail_ended

func _ready() -> void:
	points[0] = global_position
	points[1] = global_position

func _process(delta: float) -> void:
	
	if going_forward:
		points[0] = head_position
		
		if points[0].distance_to(points[1]) > max_length:
			points[1] = points[0] + points[0].direction_to(points[1]) * max_length
	
	else:
		points[1] = points[1].move_toward(points[0], delta * 300)
		if points[0] == points[1]:
			trail_ended.emit()

func update_position(new_position):
	head_position = new_position

func set_initial_position(position):
	points[0] = position
	points[1] = position
