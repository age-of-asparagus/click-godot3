extends CanvasLayer

onready var item_list = $MarginContainer/ItemList

func _ready():
	update_counts()

func _process(delta):
	update_counts()
	
func update_counts():
	item_list.set_item_text(0, "x " + str(Global.sticks))
	item_list.set_item_text(1, "x " + str(Global.stones))
