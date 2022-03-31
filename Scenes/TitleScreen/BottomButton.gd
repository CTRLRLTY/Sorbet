extends PanelContainer


onready var create_account: Button = $CreateAccount
onready var logout: Button = $Logout


func show_button(btn: Button) -> void:
	for child in get_children():
		child.visible = btn == child
