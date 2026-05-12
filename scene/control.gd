extends Node

const SAVE_PATH = "user://username.cfg"
const API_URL = "http://100.108.248.50:5000/update_name"

@onready var line_edit = $LineEdit
@onready var http = $HTTPRequest


func _ready():
	print("LineEdit node:", line_edit)
	if http == null:
		push_error("HTTPRequest node not found!")

	load_username()

	http.request_completed.connect(_on_request_completed)



func save_username():
	var username = line_edit.text.strip_edges()

	if username == "":
		print("Username is empty, not saving")
		return


	var config = ConfigFile.new()
	config.set_value("player", "username", username)
	config.save(SAVE_PATH)

	print("Saved locally:", username)

	
	send_username_to_server(username)



func load_username():
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)

	if err == OK:
		var saved_name = config.get_value("player", "username", "")
		line_edit.text = saved_name
		print("Loaded username:", saved_name)



func send_username_to_server(username):
	var data = {
		"id": 1, 
		"username": username
	}

	var json = JSON.stringify(data)

	print("Sending to server:", json)

	var error = http.request(
		API_URL,
		["Content-Type: application/json"],
		HTTPClient.METHOD_POST,
		json
	)

	if error != OK:
		print("HTTP request failed:", error)



func _on_request_completed(_result, response_code, _headers, body):
	var text = body.get_string_from_utf8()

	print("Server response code:", response_code)
	print("Server response body:", text)
