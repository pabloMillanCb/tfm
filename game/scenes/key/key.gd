extends Area2D
class_name DoorKey

@export var is_pre_instanced = false

func _ready() -> void:
	if is_pre_instanced:
		MetSys.register_storable_object(self)


func _on_player_touch(body: Node2D) -> void:
	GameEvent.key_picked_up.emit(self, body)


func pick_up():
	if is_pre_instanced:
		MetSys.store_object(self)
	body_entered.disconnect(_on_player_touch)
