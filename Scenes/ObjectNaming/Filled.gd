extends Label


var unfilled_filter: RegEx = RegEx.new()


func _ready() -> void:
	unfilled_filter.compile("_")


func fill(idx: int, c: String) -> void:
	assert(c.length() == 1)
	assert(idx >= 0 and idx < text.length(), "out of bound index")
	
	text[idx] = c


func complete() -> bool:
	return get_unfilled().empty()


func get_unfilled() -> PoolIntArray:
	var unfilled := PoolIntArray([])
	var matches := unfilled_filter.search_all(text)
	
	for m in matches:
		unfilled.append(m.get_start())
		
	
	return unfilled
