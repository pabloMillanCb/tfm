@tool
extends Node2D
class_name EnemyWave

@export var enemies: Resource
@export var appear_particle: Resource
var wave: Node2D

signal start_wave
signal on_wave_end

func _ready() -> void:
	MetSys.register_storable_object(self)
	start_wave.connect(activate_wave)

func _process(delta: float) -> void:
	if wave != null and wave.get_children().size() == 0:
		on_wave_end.emit()
		MetSys.store_object(self)
		queue_free()


func activate_wave():
	wave = enemies.instantiate()
	for enemy in wave.get_children():
		print(enemy.position)
		var smoke: CPUParticles2D = appear_particle.instantiate()
		add_child(smoke)
		smoke.position = enemy.position
		smoke.restart()
	add_child(wave)


func _get_configuration_warnings():
	var warnings = []

	if get_node("Enemies") == null and enemies == null:
		warnings.append("Add a Node2D called Enemies with all the enemies as their child")
	elif enemies == null:
		warnings.append("Assign a Node2D to the enemies parameter")

	# Returning an empty array means "no warning".
	return warnings


func _on_enemy_wave_on_wave_end() -> void:
	pass # Replace with function body.
