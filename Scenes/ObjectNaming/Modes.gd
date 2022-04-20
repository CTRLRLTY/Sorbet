extends Control

signal passed
signal failed

enum Game {
	MULTI_CHOICE,
	FIXED_CHARARACTER,
}


onready var multi_choice: Control = $MultiChoice
onready var fixed_character: Control = $FixedCharacter

onready var crosses: Control = $Life/Crosses
onready var timer_progress: Control = $Life/TimerProgress

onready var _life_node : Control


func _ready() -> void:
	for gm in get_tree().get_nodes_in_group("GameMode"):
		if gm.has_signal("passed"):
			gm.connect("passed", self, "_on_passed")
		
		if gm.has_signal("failed"):
			gm.connect("failed", self, "_on_failed")
	
	var life_nodes := get_tree().get_nodes_in_group("LifeNode")
	
	randomize()
	
	var i := randi() % life_nodes.size()
	_life_node = life_nodes[i]
	
	for ln in life_nodes:
		ln.visible = ln == _life_node
	
	if _life_node == timer_progress:
		timer_progress.start()


func play(game_mode: int, answer: String, NAME_LIST: Array) -> void:
	reset()
	
	var m: Control
	
	match game_mode:
		Game.FIXED_CHARARACTER:
			m = fixed_character
			
		Game.MULTI_CHOICE:
			m = multi_choice
	
	for gm in get_tree().get_nodes_in_group("GameMode"):
		gm.visible = gm == m
	
	m.initiate(answer, NAME_LIST)


func play_random(answer: String, NAME_LIST: Array) -> void:
	var mode := randi() % Game.size()
	
	play(Game.values()[mode], answer, NAME_LIST)


func pause() -> void:
	for child in get_children():
		if child.has_method("pause"):
			child.pause()


func reset() -> void:
	for gm in get_tree().get_nodes_in_group("GameMode"):
		if gm.has_method("reset"):
			gm.reset()


func _on_passed() -> void:
	if _life_node == timer_progress:
		timer_progress.time = min(timer_progress.time + 3.0, timer_progress.timer_bar.max_value)
	
	emit_signal("passed")


func _on_failed() -> void:
	var failed := false
	
	if _life_node == timer_progress:
		timer_progress.time -= 3.0
		
		failed = timer_progress.time == 0.0
	elif _life_node == crosses:
		crosses.cross += 1
		
		failed = crosses.maxed()
	
	if failed:
		emit_signal("failed")
		
		_life_node.reset()
