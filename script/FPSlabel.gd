extends Label

func _process(_delta: float) -> void:

	text = "FPS: %d" % Engine.get_frames_per_second()
	
func _ready():
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	Engine.max_fps = 315
