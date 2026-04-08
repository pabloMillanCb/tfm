extends CanvasLayer

@export var max_hearts: int = 8

var hearts = []
var empty_hearts = []


func _ready() -> void:
	for i in range(max_hearts):
		add_texture_rect("res://assets/heart.png", hearts)
	for i in range(max_hearts):
		add_texture_rect("res://assets/empty_heart.png",empty_hearts)
	
	GameEvent.update_health.connect(set_hearts)


func add_texture_rect(texture_path: String, array: Array):
	var heart: TextureRect = TextureRect.new()
	heart.stretch_mode =TextureRect.STRETCH_KEEP
	heart.texture = load(texture_path)
	%HBoxContainer.add_child(heart)
	heart.visible = false
	array.push_back(heart)


func set_hearts(_max_hearts: int, current_hearts: int):
	max_hearts = _max_hearts
	var current_empty_hearts = max_hearts - current_hearts
	
	for i in hearts.size():
		if i < max_hearts and i < current_hearts:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	
	for i in empty_hearts.size():
		if i < current_empty_hearts:
			empty_hearts[i].visible = true
		else:
			empty_hearts[i].visible = false
