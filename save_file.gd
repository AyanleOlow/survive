extends Node

const SAVE_PATH = "user://player.cfg"
const SERVER_URL = "http://127.0.0.1:5000/users"



@onready var line_edit = $LineEdit

var player_uuid = ""

func _ready():
	load_player()


func generate_uuid() -> String:
	return str(Time.get_unix_time_from_system()) + "_" + str(randi())



func send_player_to_flask():
	
	var data =  {
		"uuid": player_uuid,
		"username": line_edit.text
	}
	
	var json = JSON.stringify(data)
	
	var headers = [
		"content-type: application/json"
	]
	
	$HTTPRequest.request(
		SERVER_URL,
		headers,
		HTTPClient.METHOD_POST,
		json
	)
	
func _on_http_request_request_completed(
	result,
	response_code,
	headers,
	body
):

	print("Response:", response_code)
	print(body.get_string_from_utf8())
	


func save_player():

	var config = ConfigFile.new()

	config.set_value(
		"player",
		"uuid",
		player_uuid
	)

	config.set_value(
		"player",
		"username",
		line_edit.text
	)

	config.save(SAVE_PATH)

	print("Player saved!")
	print("Username:", line_edit.text)
	print("UUID:", player_uuid)


func load_player():

	var config = ConfigFile.new()

	var err = config.load(SAVE_PATH)

	if err == OK:

		player_uuid = config.get_value(
			"player",
			"uuid",
			
		)

		if player_uuid == "":
			player_uuid = generate_uuid()

		line_edit.text = config.get_value(
			"player",
			"username",
			
		)

		print("Loaded username:", line_edit.text)

	else:

		player_uuid = generate_uuid()

		config.set_value(
			"player",
			"uuid",
			player_uuid
		)

		config.save(SAVE_PATH)

		print("Created new player")


func _on_line_edit_text_submitted(new_text):
	save_player()


func _on_start_pressed():

	save_player()
	send_player_to_flask()
