extends WorldEnvironment


func set_brightnes(value: float):
	if value >= 0.5 and value <= 1.5:
		environment.adjustment_brightness = value


func set_contrast(value: float):
	if value >= 0.75 and value <= 1.25:
		environment.adjustment_contrast = value
