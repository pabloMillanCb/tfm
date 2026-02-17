extends Collectible
class_name Upgrade

enum UpgradeType {SWORD, BREAK, BEAM, POGO, TELEPORT}

@export var type: UpgradeType = UpgradeType.SWORD
@export var wait_time := 5

func _ready() -> void:
	super()
	set_description()
	set_image()


func _collect(body: Node2D) -> void:
	$CanvasLayer.visible = true
	$ItemSprite.visible = false
	get_tree().paused = true
	(body as Player).get_new_upgrade(type)
	await get_tree().create_timer(wait_time).timeout
	get_tree().paused = false
	super(body)


func set_image():
	if type == UpgradeType.SWORD:
		$ItemSprite.play("sword")
	elif type == UpgradeType.BREAK:
		$ItemSprite.play("break")
	elif type == UpgradeType.BEAM:
		$ItemSprite.play("beam")
	elif type == UpgradeType.POGO:
		$ItemSprite.play("pogo")
	elif type == UpgradeType.TELEPORT:
		$ItemSprite.play("teleport")

#TODO: Traducir
func set_description():
	if type == UpgradeType.SWORD:
		$CanvasLayer/Label.text = "Has conseguido la espada"
	elif type == UpgradeType.BREAK:
		$CanvasLayer/Label.text = "Has conseguido el break"
	elif type == UpgradeType.BEAM:
		$CanvasLayer/Label.text = "Has conseguido el beam"
	elif type == UpgradeType.POGO:
		$CanvasLayer/Label.text = "Has conseguido el pogo"
	elif type == UpgradeType.TELEPORT:
		$CanvasLayer/Label.text = "Has conseguido teleport"
