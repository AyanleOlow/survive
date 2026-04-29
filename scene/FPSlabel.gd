extends Label

func _process(_delta: float) -> void:
	# Option 1: Using string formatting (Cleanest)
	text = "FPS: %d" % Engine.get_frames_per_second()
	
	# Option 2: Using string concatenation
	# text = "FPS: " + str(Engine.get_frames_per_second())
