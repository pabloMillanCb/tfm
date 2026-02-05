extends Resource
class_name PlayerData

var max_health: int

var has_sword_update: bool
var has_break_update: bool
var has_beam_update: bool
var has_pogo_update: bool
var has_teleport_update: bool

func _init(p_sword_update = false, p_break_update = false, 
			p_beam_update = false, p_pogo_update = false,
			p_teleport_update = false, p_max_health = 2):
	
	max_health = p_max_health
	
	has_sword_update = p_sword_update
	has_break_update = p_break_update
	has_break_update = p_break_update
	has_pogo_update = p_pogo_update
	has_teleport_update = p_teleport_update
