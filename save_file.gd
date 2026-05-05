extends Node

const SAVE_PATH = "user://username.cfg"

@onready var line_edit = $LineEdit


func _ready():
	load_username()


func save_username():
	var config = ConfigFile.new()
	config.set_value("player", "username", line_edit.text)
	config.save(SAVE_PATH)


func load_username():
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)

	if err == OK:
		line_edit.text = config.get_value("player", "username", "")


func _on_line_edit_text_submitted(new_text):
	save_username()


func _on_start_pressed() -> void:
	save_username()
