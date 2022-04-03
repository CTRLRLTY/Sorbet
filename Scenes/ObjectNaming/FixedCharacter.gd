extends Control

signal passed
signal failed

var answer: String

onready var filled: Label = $Filled
onready var characters: Control = $Characters
onready var crosses: Control = $Crosses


func _ready() -> void:
	characters.connect("character_selected", self, "_on_character_selected")


func initiate(answer: String, NAME_LIST: Array) -> void:
	self.answer = answer
	
	var max_fill_scale := 0.8
	
	var btn_count: int = char_count()
	
	var trailing := max(0, answer.length() - btn_count)
	
	var min_filled: int = randi() % crosses.count()
	var max_filled: int = floor(min(answer.length(), btn_count) * max_fill_scale)
	
	var initial_fill := randi() % max_filled
	var min_fill := abs(initial_fill - min_filled)
	var total_fill := initial_fill + trailing + min_fill
	
#	print_debug(min_filled, " ", min_fill, " ", max_filled, " ", initial_fill, " ", total_fill)
	
	var filled_index := []
	
	for i in range(total_fill):
		var index := randi() % answer.length()
		filled_index.append(index)
	
	filled.text = "_".repeat(answer.length())
	
	var unfilled_index := []
	
	for i in answer.length():
		if filled_index.has(i):
			filled.text[i] = answer[i]
		else:
			unfilled_index.append(i)
	
	var characters := []
	
	for i in unfilled_index:
		characters.append(answer[i])
	
	var noise := []
	
	for i in btn_count - characters.size():
		var ascii := (randi() % 25 + 1) + 97
		var c := char(ascii)
		
		while characters.has(c) or noise.has(c):
			ascii = (randi() % 25 + 1) + 97
			c = char(ascii)
		
		noise.append(c)
	
	characters.append_array(noise)
	characters.shuffle()
	
	set_characters(characters)


func reset() -> void:
	for btn in characters.button_group.get_buttons():
		btn.disabled = false
	
	crosses.cross = 0


func set_characters(chars: PoolStringArray) -> void:
	var buttons: Array = characters.button_group.get_buttons()
	
	assert(chars.size() == buttons.size())
	
	for i in range(buttons.size()):
		buttons[i].text = chars[i]


func char_count() -> int:
	var buttons: Array = characters.button_group.get_buttons()
	
	return buttons.size()


func _on_character_selected(c: String) -> void:
	var unfilled: PoolIntArray = filled.get_unfilled()
	
	var correct_answer := false
	
	for i in unfilled:
		if c == answer[i]:
			filled.text[i] = c
			
			correct_answer = true
			
			break
	
	if correct_answer:
		if filled.complete():
			emit_signal("passed")
	else:
		crosses.cross += 1
		
		if crosses.maxed():
			emit_signal("failed")
