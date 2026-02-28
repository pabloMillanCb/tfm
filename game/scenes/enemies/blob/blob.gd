extends EnemyCharacter

@export var speed = 35
@export var gravity = 200
@export var direction = 1.0

@onready var ray_cast = $AnimatedSprite2D/RayCast2D

func _ready() -> void:
	$AnimatedSprite2D.scale.x = direction


func _physics_process(delta: float) -> void:
	
	if !is_on_floor():
		velocity.y += delta * 200
	
	if !hit and is_on_floor():
		if $Walk.time_left > 0:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, delta * 100)
			
		if ray_cast.get_collider() and $TurnTimer.time_left == 0:
			direction = -direction
			$AnimatedSprite2D.scale.x = direction
			$TurnTimer.start()
	
	move_and_slide()


func take_damage(direction: Vector2 = Vector2.ZERO):
	$AnimationPlayer.play("hit_enemy")
	super(direction)


func _on_animation_finished() -> void:
	if $AnimatedSprite2D.animation == StringName("to_walk"):
		$AnimatedSprite2D.play("walk")


func _on_wait_timeout() -> void:
	$AnimatedSprite2D.play("to_walk")
	$Walk.start()


func _on_walk_timeout() -> void:
	$AnimatedSprite2D.play("to_idle")
	$Wait.start()
