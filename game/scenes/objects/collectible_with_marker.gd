extends Area2D
class_name CollectibleWithMarker

var parent: Node

func _ready() -> void:
	MetSys.register_storable_object_with_marker(self)

func _collect(body: Node2D) -> void:
	MetSys.store_object(self)
	queue_free()
