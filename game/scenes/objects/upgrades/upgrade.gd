extends Collectible
class_name Upgrade

enum UpgradeType {SWORD, BREAK, BEAM, POGO, TELEPORT}

@export var type: UpgradeType = UpgradeType.SWORD
@export var wait_time := 5

signal upgrade_picked

func _ready() -> void:
	super()
	set_image()


func _collect(body: Node2D) -> void:
	$CanvasLayer.visible = true
	$ItemSprite.visible = false
	get_tree().paused = true
	(body as Player).get_new_upgrade(type)
	$CanvasLayer.visible = true
	await get_tree().create_timer(wait_time).timeout
	get_tree().paused = false
	upgrade_picked.emit()
	super(body)


func set_image():
	if type == UpgradeType.SWORD:
		$ItemSprite.play("sword")
		%ItemName.text = "SWORD_NAME"
		%ItemInstruction.text = "SWORD_INSTRUCTION"
		%ItemTexture.texture = preload("res://scenes/objects/upgrades/assets/sword.png")
		%ActionIcon.action_name = StringName("atack")
	elif type == UpgradeType.BREAK:
		$ItemSprite.play("break")
		%ItemName.text = "BREAK_NAME"
		%ItemInstruction.text = "BREAK_INSTRUCTION"
		%ItemTexture.texture = preload("res://scenes/objects/upgrades/assets/break.png")
		%ActionIcon.visible = false
	elif type == UpgradeType.BEAM:
		pass
	elif type == UpgradeType.POGO:
		$ItemSprite.play("pogo")
		%ItemName.text = "POGO_NAME"
		%ItemInstruction.text = "POGO_INSTRUCTION"
		%ItemTexture.texture = preload("res://scenes/objects/upgrades/assets/pogo.png")
		%ActionIcon.action_name = StringName("aim_down")
	elif type == UpgradeType.TELEPORT:
		$ItemSprite.play("teleport")
		%ItemName.text = "TELEPORT_NAME"
		%ItemInstruction.text = "TELEPORT_INSTRUCTION"
		%ItemTexture.texture = preload("res://scenes/objects/upgrades/assets/wand.png")
		%ActionIcon.action_name = StringName("teleport")
