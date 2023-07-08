extends CanvasLayer

#var item_list : ItemList
onready var item_list : ItemList = $ItemList
onready var item_list_spaces = item_list.get_item_count()

func _ready():

	var i = 0
	for item in Global.items.values():
		if i < item_list_spaces:
			item_list.set_item_disabled(i, false)
			item_list.set_item_text(i, str(item.count))
			item_list.set_item_icon(i, item.texture)
#			item_list.set_it
			i = i + 1

func _process(delta):
	update_counts()
	
func update_counts():
	var i = 0
	for item in Global.items.values():
		if i < item_list_spaces:
			item_list.set_item_text(i, str(item.count))
			i = i + 1
