extends CollectibleWithMarker


func _collect(body: Node2D) -> void:
	GameEvent.heart_picked.emit()
	super(body)
