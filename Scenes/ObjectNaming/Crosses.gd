extends HBoxContainer

export var CrossEmptyTexture: Texture
export var CrossFilledTexture: Texture

var cross := 0 setget set_cross

func count() -> int:
	return get_child_count()
	

func maxed() -> bool:
	return cross == get_child_count()


func set_cross(amount: int) -> void:
	var old_val := cross
	cross = clamp(amount, 0, get_child_count())
	
	for i in old_val:
		var cross_rect: TextureRect = get_child(i)
		
		cross_rect.texture = CrossEmptyTexture
	
	for i in cross:
		var cross_rect: TextureRect = get_child(i)
		
		cross_rect.texture = CrossFilledTexture
