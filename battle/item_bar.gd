extends Node2D

var pea_shooter_card = preload("res://plants/pea_shooter/pea_shooter_card.tscn").instantiate();
var pea_shooter = preload("res://plants/pea_shooter/pea_shooter.tscn").instantiate();
var plant_selected = null;
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
	
	for i in range(9):		
		var plant_card = load("res://battle/plant_card.tscn").instantiate();
		plant_card.position = Vector2(80 + i * 54, 10);
		var card_sprite = load("res://plants/pea_shooter/pea_shooter_card.tscn").instantiate();
		plant_card.set_plant(card_sprite, 100);
		plant_card.connect("plant_selected", _on_plant_select);
		add_child(plant_card);				
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion and plant_selected != null:
		plant_selected.position = event.position;
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if plant_selected != null:
				remove_child(plant_selected);
				plant_selected = null;	
	pass

func _on_plant_select(sprite):
	if plant_selected != null:
		remove_child(plant_selected);
	plant_selected = get_plant_selected_sprite("pea_shooter");
	plant_selected.position = Input.get_last_mouse_velocity();
	add_child(plant_selected);
	pass
	
func get_plant_selected_sprite(plant_name):
	match plant_name:
		"pea_shooter":
			return pea_shooter;
		_:
			pass;
	pass
