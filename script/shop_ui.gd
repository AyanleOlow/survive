extends Control

var player_inventory

var items = {
	"pistol": 20,
	"shoutgun": 30,
	"sniper": 50
}

func _ready():
	visible = false
	return
	player_inventory = get_node("/root/Game/PlayerInventory")

func open():
	visible = true

func close():
	visible = false
	get_tree().paused = false

func buy_item(item_name):

	var cost = items[item_name]

	if player_inventory.money >= cost:

		player_inventory.money -= cost
		player_inventory.add_item(item_name)

		print("Bought ", item_name)

	else:
		print("Not enough money")

func _on_pistol_pressed() -> void:
	buy_item("pistol")
	

func _on_shoutgun_pressed() -> void:
	buy_item("shoutgun")

func _on_sniper_pressed() -> void:
	buy_item("sniper")

func _on_close_button_pressed():
	close()
