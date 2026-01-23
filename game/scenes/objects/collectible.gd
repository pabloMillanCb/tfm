extends Area2D
class_name Collectible

var parent: Node

func _ready() -> void:
	MetSys.register_storable_object(self)

func _collect(body: Node2D) -> void:
	MetSys.store_object(self)
	queue_free()
