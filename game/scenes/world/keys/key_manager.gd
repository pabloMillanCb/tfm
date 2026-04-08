extends Node2D

signal world_room_changed

var vector_to_player: Vector2
var key: DoorKey
var player: Player

var player_target_modifier = Vector2(0, -8)
@export var speed_factor: float = 2.0
var changing_room = false

func _ready() -> void:
	GameEvent.key_picked_up.connect(_on_key_pick_up)
	GameEvent.key_used.connect(_on_key_used)
	world_room_changed.connect(_on_room_changed)


func _on_key_pick_up(key_: DoorKey, player_: Player):
	print("key pick up")
	if key == null:
		key = key_
		player = player_
		var key_global_position = key.global_position
		key.get_parent().remove_child(key)
		add_child(key)
		key.global_position = key_global_position
		key.pick_up()
		player.data.has_key = true


func _on_key_used():
	key = null
	player.data.has_key = false


func _on_room_changed():
	if key != null:
		changing_room = true
		vector_to_player = player.global_position - key.global_position  
		key.visible = false
		
		get_tree().create_timer(0.05).timeout.connect(func():
			key.visible = true
			changing_room = false
		)


func _physics_process(delta: float) -> void:
	if key != null:
		if changing_room:
			key.global_position = player.global_position - vector_to_player
		else:
			const PLAYER_TARGET_MODIFIER = Vector2(0, -8)
			var target_position = player.global_position + PLAYER_TARGET_MODIFIER
			var distance_to_player = key.global_position.distance_to(target_position)
			key.global_position = key.global_position.move_toward(
				target_position, 
				delta * distance_to_player * speed_factor)
