extends Node2D

signal world_room_changed

var vector_to_player: Vector2
var key: Key

func _ready() -> void:
	GameEvent.key_picked_up.connect(_on_key_pick_up)
	GameEvent.key_used.connect(_on_key_used)
	world_room_changed.connect(_on_room_changed)


func _on_key_pick_up(key_: Key):
	print("key pick up")
	key = key_
	var key_global_position = key.global_position
	key.get_parent().remove_child(key)
	add_child(key)
	key.global_position = key_global_position


func _on_key_used():
	print("key used")
	key = null


func _on_room_changed():
	print("room changed")
	if key != null:
		key.following_player = false
		vector_to_player = key.global_position.direction_to(key.player.global_position) * key.global_position.distance_to(key.player.global_position)   
		
		key.visible = false
		get_tree().create_timer(0.05).timeout.connect(func():
			key.visible = true
			key.following_player = true
			)

func _physics_process(delta: float) -> void:
	if key != null and key.following_player == false:
		key.global_position = key.player.global_position - vector_to_player
