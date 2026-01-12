extends State
class_name PlayerState

const IDLE = "Idle"
const MOVE = "Move"
const JUMP = "Jump"
const FALLING = "Falling"
const ATACK = "Atack"
const PREPARE_TELEPORT = "PrepareTeleport"
const RELEASE_TELEPORT = "ReleaseTeleport"
const POGO = "Pogo"
const HIT = "Hit"
const DEAD = "Dead"

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
