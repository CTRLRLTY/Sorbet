extends Control

onready var login_screen: Control = find_node("LoginScreen")
onready var user_screen: Control = find_node("UserScreen")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_screen(login_screen)


func show_screen(screen: Control) -> void:
	assert(is_a_parent_of(screen))
	
	for node in get_tree().get_nodes_in_group("auth_screen"):
		node.hide()
	
	screen.show()


func _on_LoginScreen_guest_login() -> void:
	show_screen(user_screen)
