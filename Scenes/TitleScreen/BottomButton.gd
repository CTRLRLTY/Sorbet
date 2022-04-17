extends PanelContainer


onready var create_account: Button = $CreateAccount
onready var profile: Button = $Profile


func show_button(btn: Button) -> void:
	for child in get_children():
		child.visible = btn == child
