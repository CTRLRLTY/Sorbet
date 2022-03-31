extends PanelContainer


onready var login_screen: Control = $LoginScreen
onready var user_screen: Control = $UserScreen


func show_screen(screen: Control) -> void:
	assert(is_a_parent_of(screen))
	
	for node in get_tree().get_nodes_in_group("auth_screen"):
		node.hide()
	
	screen.show()
