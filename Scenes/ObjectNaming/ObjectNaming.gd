extends Control

# Equal RNG Bagging algorithm
class RNGBagSlot:
	var item_bag : Array
	var _unique_items := []
	
	func _init(item_list : Array) -> void:
		item_bag = []
		_unique_items = item_list

#########    THIS SECTION IS MODIFIABLE
		_add_equal(item_list)
	
	func _add_equal(item_list : Array) -> void:
		for item in item_list:
		   #########   THIS IS OPTIONAL
			# The amount (3) can be change to N for either less/more rebalancing.
			# This controls the depth.
			for _i in range(3):
				item_bag.push_back(item)

	func get_random_item():
		var selected_item = item_bag[randi() % item_bag.size()]
		
		item_bag.erase(selected_item)

		if item_bag.count(selected_item) <= 1:
			 # Bag rebalancing
			item_bag.append_array(_unique_items)
			
		return selected_item


const NAME_LIST := [
	"cow",
	"dog",
	"horse",
	"chicken",
	"duck",
	"sheep",
	"cat",
	"rabbit",
]


var object_name: String

var milestone_position := 0 setget set_milestone_position
var milestone_steps := 5
var milestone_step_point := 10

var decrease_on_wrong_amount := 2.0


var _name_bag: RNGBagSlot


onready var object_rect: TextureRect = $ObjectRect
onready var modes: Control = $Modes
onready var milestone: Control = $Milestone
onready var centered_dialog: Control = $CenteredDialog
onready var buttons: Control = $BottomButtons


func _ready() -> void:
	RuntimeManager.point_accumulated = 0
	
	_name_bag = RNGBagSlot.new(NAME_LIST)
	
	modes.multi_choice.connect("choice_selected", self, "_on_choice_selected")
	modes.multi_choice.timer_progress.connect("timeout", self, "_on_timer_timeout")
	
	modes.fixed_character.connect("character_selected", self, "_on_character_selected")
	
	buttons.connect("quit_request", self, "_on_quit_request")
	
	centered_dialog.connect("quit", self, "_on_quit")
	centered_dialog.connect("menu", self, "_on_menu")
	centered_dialog.connect("play_again", self, "_on_play_again")
	
	for step in range(milestone_steps):
		milestone.add_milestone(milestone.MilestoneType.EMPTY)
	
	milestone.set_milestone_type(milestone_steps - 1, milestone.MilestoneType.FLAG_EMPTY)
	
	randomize()
	randomize_object()


func randomize_object() -> void:
	var TEX_DIR := "res://Resources/Animals/"
	
	object_name = _name_bag.get_random_item()
	
	var res_path := TEX_DIR + object_name + ".png"
	var texture: Texture = load(res_path)
	
	object_rect.texture = texture
	
#	randomize_multi_choice()
	randomize_fixed_character()


func randomize_multi_choice() -> void:
	var choice_count: int = modes.multi_choice.choice_count()
	
	var choices := []
	var buf := NAME_LIST.duplicate()
	
	for idx in range(choice_count):
		var i: int = randi() % buf.size()
		
		var oname: String = buf.pop_at(i)
		choices.append(oname)
	
	# Does choices contain one solution?
	if not choices.has(object_name):
		# Place the answer randomly
		var answer_index := randi() % choice_count
		choices[answer_index] = object_name
		
	modes.multi_choice.set_choices(choices)
	modes.multi_choice.timer_progress.start()


func randomize_fixed_character() -> void:
	var fixed_character: Control = modes.fixed_character
	var filled: Label = fixed_character.filled
	
	var max_fill_scale := 0.8
	
	var btn_count: int = fixed_character.char_count()
	
	var trailing := max(0, object_name.length() - btn_count)
	
	var min_filled: int = fixed_character.crosses.count()
	var max_filled: int = floor(min(object_name.length(), btn_count) * max_fill_scale)
	
	var initial_fill := randi() % max_filled
	var min_fill := abs(initial_fill - min_filled)
	var total_fill := initial_fill + trailing + min_fill
	
#	print_debug(min_filled, " ", min_fill, " ", max_filled, " ", initial_fill, " ", total_fill)
	
	var filled_index := []
	
	fixed_character.reset()
	
	for i in range(total_fill):
		var index := randi() % object_name.length()
		filled_index.append(index)
	
	filled.text = "_".repeat(object_name.length())
	
	var unfilled_index := []
	
	for i in object_name.length():
		if filled_index.has(i):
			filled.text[i] = object_name[i]
		else:
			unfilled_index.append(i)
	
	var characters := []
	
	for i in unfilled_index:
		characters.append(object_name[i])
	
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
	
	fixed_character.set_characters(characters)


func set_milestone_position(pos: int) -> void:
	milestone_position = pos
	var flag_reached := milestone_position == milestone_steps
	
	if flag_reached:
		centered_dialog.popup_over_dialog()


func _on_choice_selected(choice: String) -> void:
	var flag_reached := milestone_position == milestone_steps

	if flag_reached:
		modes.multi_choice.timer_progress.stop()
		
		return
	
	if choice == object_name:
		milestone.set_milestone_type(milestone_position, 
				milestone.MilestoneType.SUCCESS)
				
		RuntimeManager.point_accumulated += milestone_step_point
				
		self.milestone_position += 1
		
		modes.multi_choice.timer_progress.start()
		
		randomize_object()
	else:
		var time_left = modes.multi_choice.timer_progress.time_left()
		var time_sec: float = max(time_left - decrease_on_wrong_amount, 0)
		
		modes.multi_choice.timer_progress.start(time_sec)


func _on_character_selected(c: String) -> void:
	var fixed_character: Control = modes.fixed_character
	var filled: Label = fixed_character.filled
	var unfilled: PoolIntArray = filled.get_unfilled()
	var crosses: Control = fixed_character.crosses
	
	var correct_answer := false
	
	for i in unfilled:
		if c == object_name[i]:
			filled.text[i] = c
			
			correct_answer = true
			
			break
	
	if correct_answer:
		if filled.complete():
			milestone.set_milestone_type(milestone_position, 
				milestone.MilestoneType.SUCCESS)
			
			RuntimeManager.point_accumulated += milestone_step_point
			
			self.milestone_position += 1
			
			randomize_object()
	else:
		crosses.cross += 1
		
		if crosses.maxed():
			milestone.set_milestone_type(milestone_position, 
					milestone.MilestoneType.FAIL)
			
			RuntimeManager.point_accumulated -= milestone_step_point
			
			self.milestone_position += 1
			
			randomize_object()


func _on_timer_timeout() -> void:
	milestone.set_milestone_type(milestone_position, 
			milestone.MilestoneType.FAIL)
	
	RuntimeManager.point_accumulated -= milestone_step_point

	self.milestone_position += 1


func _on_quit_request() -> void:
	centered_dialog.popup_quit_dialog()


func _on_quit() -> void:
	SceneManager.goto_level_selection()


func _on_menu() -> void:
	SceneManager.goto_title_screen()


func _on_play_again() -> void:
	get_tree().reload_current_scene()
