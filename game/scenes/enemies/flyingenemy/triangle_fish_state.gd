extends State
class_name TriangleFishState

const SLEEP = "Sleep"
const WATCH = "Watch"
const CHASE = "Chase"
const HIT = "Hit"
const DEAD = "Dead"

var fish: TriangleFish

func _ready() -> void:
	await owner.ready
	fish = owner as TriangleFish
	assert(fish != null, "The TriangleFishState state type must be used only in the triangle fish scene. It needs the owner to be a TriangleFish node.")
