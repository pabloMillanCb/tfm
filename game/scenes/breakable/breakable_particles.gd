extends Node2D

var is_wall = false

func _ready() -> void:
	if is_wall == false:
		$CPUParticles2D2.color = "ffffff"
		$SkullSound.play()
	else:
		$WallSound.play()
		$CPUParticles2D2.color = "639bff"
	$CPUParticles2D2.restart()

func _on_wall_sound_finished() -> void:
	queue_free()


func _on_skull_sound_finished() -> void:
	queue_free()
