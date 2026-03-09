extends CollectibleWithMarker


func _collect(body: Node2D) -> void:
	GameEvent.heart_picked.emit()
	if body is Player:
		print("player pickup")
		body.pick_up_heart()
	super(body)
