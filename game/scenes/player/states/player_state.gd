extends State
class_name PlayerState

const IDLE = "Idle"
const MOVE = "Move"
const JUMP = "Jump"
const FALLING = "Falling"
const SUPER_FALLING = "SuperFalling"
const ATACK = "Atack"
const PREPARE_TELEPORT = "PrepareTeleport"
const RELEASE_TELEPORT = "ReleaseTeleport"
const POGO = "Pogo"
const HIT = "Hit"
const DEAD = "Dead"
const TALKING = "Talking"
const STOMP = "Stomp"

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")


func _on_hit_received():
	print("on hit received")
	finished.emit(HIT)


func force_jump():
	finished.emit(JUMP, {"extra_force": -60})
