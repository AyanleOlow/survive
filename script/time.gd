extends Label

const SAVE_PATH = "user://player.cfg"

var time_left = 0

func _ready():
	text = "TIME: " + str(time_left)

	$Timer.wait_time = 1.0
	$Timer.start()

func _on_timer_timeout():
	time_left += 1

	text = "TIME: " + str(time_left)

	if time_left <= 0:
		$Timer.stop()
		text = "TIME: 0"

func _notification(what):

	if what == NOTIFICATION_WM_CLOSE_REQUEST:

		save_playtime()

		get_tree().quit()

func save_playtime():

	var config = ConfigFile.new()

	config.load(SAVE_PATH)

	config.set_value(
		"player",
		"playtime",
		time_left
	)

	config.save(SAVE_PATH)

	print("Player was in game for", time_left, "seconds")

func _input(event):

	if event.is_action_pressed("esc"):

		save_playtime()

		print("Leaving game after ", time_left, " seconds")

		get_tree().quit()
