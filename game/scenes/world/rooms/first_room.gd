extends Node2D

func _ready() -> void:
	print("forbiden")
	print(DataManager.is_event_registered("forbiden"))
	if DataManager.get_event_value("h") == true and DataManager.is_event_registered("forbiden") != true:
		var f = preload("res://scenes/npc/f.tscn").instantiate()
		add_child(f)


func _on_area_2d_body_entered(body: Node2D) -> void:
	GameEvent._on_game_escaped.emit()
