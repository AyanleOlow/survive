extends Label

var time_left = 30

func _ready():
	text = "TIME: " + str(time_left)

	$Timer.wait_time = 1.0
	$Timer.start()

func _on_timer_timeout():
	time_left -= 1

	text = "TIME: " + str(time_left)

	if time_left <= 0:
		$Timer.stop()
		text = "TIME: 0"
