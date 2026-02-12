extends State
class_name AxoloteState

const IDLE = "Idle"
const MOVE = "Move"
const RUN = "Run"
const HIT = "Hit"
const DEAD = "Dead"

var axolote: Axolote

func _ready() -> void:
	await owner.ready
	axolote = owner as Axolote
	assert(axolote != null, "The AxoloteState state type must be used only in the axolote scene. It needs the owner to be a Axolote node.")
