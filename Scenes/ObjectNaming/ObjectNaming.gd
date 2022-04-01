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
var decrease_on_wrong_amount := 2.0


var _name_bag: RNGBagSlot


onready var object_rect: TextureRect = $ObjectRect
onready var modes: Control = $Modes
onready var milestone: Control = $Milestone
onready var centered_dialog: Control = $CenteredDialog
onready var buttons: Control = $BottomButtons


func _ready() -> void:
	_name_bag = RNGBagSlot.new(NAME_LIST)
	
	modes.multi_choice.connect("choice_selected", self, "_on_choice_selected")
	modes.multi_choice.timer_progress.connect("timeout", self, "_on_timer_timeout")
	buttons.connect("quit_request", self, "_on_quit_request")
	
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


func set_milestone_position(pos: int) -> void:
	milestone_position = pos
	var flag_reached := milestone_position == milestone_steps
	
	if flag_reached:
		print_debug("Done!")
	else:
		randomize_object()
		
		modes.multi_choice.timer_progress.start()


func _on_choice_selected(choice: String) -> void:
	if choice == object_name:
		milestone.set_milestone_type(milestone_position, 
				milestone.MilestoneType.SUCCESS)
				
		self.milestone_position += 1
	else:
		var time_left = modes.multi_choice.timer_progress.time_left()
		var time_sec: float = max(time_left - decrease_on_wrong_amount, 0)
		
		modes.multi_choice.timer_progress.start(time_sec)


func _on_timer_timeout() -> void:
	milestone.set_milestone_type(milestone_position, 
			milestone.MilestoneType.FAIL)

	self.milestone_position += 1


func _on_quit_request() -> void:
	centered_dialog.popup_quit_dialog()
