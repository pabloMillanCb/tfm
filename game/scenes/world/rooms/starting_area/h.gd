extends Node2D


func _ready() -> void:
	if DataManager.is_event_registered("h_l"):
		$Sprite2D.position.y = -119.22


func _on_area_2d_body_entered(body: Node2D) -> void:
	$AnimationPlayer.play("up")
	#TODO: sonidorision
