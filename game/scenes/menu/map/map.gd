extends Panel

@export var player: Player

var SIZE: Vector2i
var map_view: MapView
var zoom_level = 1.0
var player_location: Node2D
var offset: Vector2i


func _ready() -> void:
	SIZE = size / MetSys.CELL_SIZE
	map_view = MetSys.make_map_view(self, -SIZE / 2, SIZE, 0)
	
	player_location = MetSys.add_player_location(self)
	update_offset()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			if event.is_action("map") and visible:
				hide_map()
			elif event.is_action("map") and !visible:
				show_map()
			if visible:
				var move_offset: Vector2i
				if event.is_action("move_left"):
					print("move left")
					move_offset = Vector2i.LEFT
				elif event.is_action("move_right"):
					print("move left")
					move_offset = Vector2i.RIGHT
				elif event.is_action("aim_down"):
					move_offset = Vector2i.DOWN
				elif event.is_action("aim_up"):
					move_offset = Vector2i.UP
				
				map_view.move(move_offset)
				player_location.offset = -Vector2(map_view.begin) * MetSys.CELL_SIZE
				offset += move_offset


func show_map():
	visible = true
	update_offset()
	get_tree().paused = true


func hide_map():
	visible = false
	get_tree().paused = false

func update_offset():
	offset = MetSys.get_current_flat_coords() - SIZE / 2
	# Player position node needs to be moved accordingly.
	player_location.offset = -Vector2(offset) * MetSys.CELL_SIZE
	# Updates map view initial position.
	map_view.move_to(Vector3i(offset.x, offset.y, MetSys.current_layer))
	# Update all cells of MapView to reflect the current state.
	map_view.update_all()
