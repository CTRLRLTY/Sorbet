extends Control

onready var screens: Control = $Screens
onready var bottom_button: Control = $BottomButton
onready var profile_dialog: Control = $ProfileDialog


func _ready() -> void:
	screens.show_screen(screens.login_screen)
	bottom_button.show_button(bottom_button.create_account)
	
	if RuntimeManager.login:
		screens.show_screen(screens.user_screen)
		bottom_button.show_button(bottom_button.profile)


func _on_Guest_pressed() -> void:
	screens.show_screen(screens.user_screen)
	bottom_button.show_button(bottom_button.profile)
	
	Server.login_device()


func _on_Logout_pressed() -> void:
	screens.show_screen(screens.login_screen)
	bottom_button.show_button(bottom_button.create_account)
	
	Server.logout()


func _on_Profile_pressed() -> void:
	profile_dialog.show()
