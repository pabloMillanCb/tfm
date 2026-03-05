extends Node2D

@export var curve: Curve = Curve.new()
@export var follow: PathFollow2D
@export var element: Node2D

@export var speed = 1

var time = 0.0

func _process(delta: float) -> void:
	time += delta
	follow.progress_ratio = curve.sample((1+sin(time*speed*2))/2)
	element.position = follow.position
