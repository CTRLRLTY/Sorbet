extends CenterContainer

enum MilestoneType {
	EMPTY,
	SUCCESS,
	FAIL,
}

onready var hbox: HBoxContainer = $HBox


func _ready() -> void:
	add_milestone(MilestoneType.EMPTY)
	add_milestone(MilestoneType.EMPTY)
	add_milestone(MilestoneType.EMPTY)
	add_milestone(MilestoneType.EMPTY)
	add_milestone(MilestoneType.EMPTY)


func milestone_count() -> int:
	return get_child_count()


func add_milestone(milestone_type := MilestoneType.EMPTY) -> void:
	var add_seperator := bool(hbox.get_child_count() % 2)
	
	if add_seperator:
		var seperator := Panel.new()
		var stylebox := StyleBoxFlat.new()
		
		seperator.rect_min_size = Vector2(24, 12)
		
		stylebox.bg_color = Color("#999D9F")
		
		seperator.add_stylebox_override("panel", stylebox)
		seperator.size_flags_vertical = SIZE_EXPAND | SIZE_SHRINK_CENTER
		
		hbox.add_child(seperator)
	
	var milestone: TextureRect = TextureRect.new()
	
	milestone.texture = _milestone_texture(milestone_type)

	hbox.add_child(milestone)


func set_milestone_type(idx: int, milestone_type: int) -> void:
	assert(hbox.get_child_count() >= 0 or hbox.get_child_count() <= idx, "index out of bound")
	
	var milestone: TextureRect = hbox.get_child(idx)
	
	milestone.texture = _milestone_texture(milestone_type)


func _milestone_texture(milestone_type: int) -> Texture:
	var texture : Texture
	
	match milestone_type:
		MilestoneType.EMPTY:
			texture = load("res://Resources/Textures/milestone_empty.png")
		MilestoneType.SUCCESS:
			texture = load("res://Resources/Textures/milestone_success.png")
		MilestoneType.FAIL:
			texture = load("res://Resources/Textures/milestone_fail.png")
	
	return texture
