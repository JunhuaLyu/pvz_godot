extends Node2D

signal plant_selected(name)
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(8):		
		var item_rect = Sprite2D.new();
		item_rect.texture = load("res://battle/item_bar.png");
		item_rect.centered = false;
		item_rect.region_enabled = true;
		item_rect.region_rect = Rect2(140, 0, 60, 87);
		item_rect.position = Vector2(78 + i * 60, 0);
		add_child(item_rect);

	var bar_end_rect = Sprite2D.new();
	bar_end_rect.texture = load("res://battle/item_bar.png");
	bar_end_rect.centered = false;
	bar_end_rect.region_enabled = true;
	bar_end_rect.region_rect = Rect2(391, 0, 24, 87);
	bar_end_rect.position = Vector2(78 + 8 * 60, 0);
	add_child(bar_end_rect);
	
	var plant_card = load("res://battle/plant_card.tscn").instantiate();
	plant_card.position = Vector2(80, 10);
	var card_sprite = load("res://plants/sunflower/sunflower_card.tscn").instantiate();	
	plant_card.set_plant("sunflower", card_sprite, 50);
	plant_card.connect("plant_selected", _on_plant_select);
	add_child(plant_card);				
	
	plant_card = load("res://battle/plant_card.tscn").instantiate();
	plant_card.position = Vector2(80 + 1 * 54, 10);
	card_sprite = load("res://plants/pea_shooter/pea_shooter_card.tscn").instantiate();
	plant_card.set_plant("pea_shooter", card_sprite, 100);
	plant_card.connect("plant_selected", _on_plant_select);
	add_child(plant_card);				
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_plant_select(name):
	plant_selected.emit(name);
	pass
