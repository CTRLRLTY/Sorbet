extends Node

var client: NakamaClient
var session: NakamaSession

var _session_var := {
	"device_os": OS.get_name(),
	"device_model": OS.get_model_name()
}


func _ready() -> void:
	_setup_client(10)


func _setup_client(timeout: int) -> void:
	var scheme = "http"
	var host = "127.0.0.1"
	var port = 7350
	var server_key = "defaultkey"
	
	client = Nakama.create_client(server_key, host, port, scheme)
	
	client.timeout = timeout


func login_device() -> void:
	var id := OS.get_unique_id()
	
	session = yield(client.authenticate_device_async(id, "GOD", true, _session_var), "completed")
	
	if session.is_exception():
		print_debug("Device login failed: %s" % session)
		
		RuntimeManager.login = false
	else:
		RuntimeManager.login = true


func refresh_session():
	session = yield(client.session_refresh_async(session), "completed")
	
	if session.is_exception():
		print_debug("Failed to refresh session: %s" % session)


func logout() -> void:
	yield(client.session_logout_async(session), "completed")
	
	RuntimeManager.login = false
