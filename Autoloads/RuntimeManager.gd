extends Node

signal user_login
signal user_logout


var login := false setget set_login
var point_accumulated := 0

var points := 0 


func _ready() -> void:
	OS.low_processor_usage_mode = true


func set_login(p_login: bool) -> void:
	login = p_login 
	
	if login:
		emit_signal("user_login")
	else:
		emit_signal("user_logout")
