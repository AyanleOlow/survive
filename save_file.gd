extends Node

const SAVE_PATH = "user://username.cfg"
const API_URL = "http://100.108.248.50:5000/users"

@onready var line_edit = $LineEdit
@onready var http = get_node("HTTPRequest")


func _ready():
	load_username()


func save_username():
	var config = ConfigFile.new()
	config.set_value("player", "username", line_edit.text)
	config.save(SAVE_PATH)

	send_username_to_server(line_edit.text)


func load_username():
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)

	if err == OK:
		line_edit.text = config.get_value("player", "username", "")



func send_username_to_server(username):
	var data = {
		"id": 1, 
		"username": username
	}

	var json = JSON.stringify(data)

	http.request(
		API_URL,
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		json
	)



func _on_request_completed(result, response_code, headers, body):
	var text = body.get_string_from_utf8()
	print("Server response:", text)


func _on_line_edit_text_submitted(new_text):
	save_username()


func _on_start_pressed() -> void:
	save_username()
