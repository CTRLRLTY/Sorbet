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
	
	RuntimeManager.login = true
	
#	Server.login_device()
	
#	OS.shell_open("https://accounts.google.com/o/oauth2/v2/auth?scope=https://www.googleapis.com/auth/userinfo.profile&client_id=990459061327-el1bs4q0tdk7e3odd301md3mdatru0sk.apps.googleusercontent.com&redirect_uri=urn:ietf:wg:oauth:2.0:oob&response_type=code")


func _on_Logout_pressed() -> void:
	screens.show_screen(screens.login_screen)
	bottom_button.show_button(bottom_button.create_account)
	RuntimeManager.login = false
#	Server.logout()


func _on_Profile_pressed() -> void:
	profile_dialog.show()
