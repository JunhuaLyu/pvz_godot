extends Node2D

#var pea_shooter = preload("res://plants/pea_shooter/pea_shooter.tscn").instantiate();
#var sunflower = preload("res://plants/sunflower/sunflower.tscn").instantiate();

var plant_selected = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	$item_bar.connect("plant_selected", _on_plant_select);
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
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if plant_selected != null and match_plant_field(event.position):
				plant_selected = null;	
	pass

func match_plant_field(position):
	for i in range(9):
		for j in range(5):
			if position.x > 145 + i * 80 - 30 and position.x < 145 + i * 80 + 30 and position.y > 135 + j * 97 - 40 and position.y < 135 + j * 97 + 40:
				plant_selected.position = Vector2(145 + i * 80, 135 + j * 97);
				return true;
			# var plant_rect = Sprite2D.new();
			# plant_rect.texture = load("res://battle/item_bar.png");
			# plant_rect.region_enabled = true;
			# plant_rect.region_rect = Rect2(140, 0, 60, 60);
			#plant_rect.position = Vector2(145 + i * 80, 135 + j * 97);
			#add_child(plant_rect);
	return false;
	
func _on_plant_select(name):
	if plant_selected != null:
		remove_child(plant_selected);
	plant_selected = get_plant_selected_sprite(name);
	if plant_selected != null:
		plant_selected.position = Input.get_last_mouse_velocity();
		add_child(plant_selected);
	pass
	
func get_plant_selected_sprite(plant_name):
	match plant_name:
		"pea_shooter":
			return load("res://plants/pea_shooter/pea_shooter.tscn").instantiate();
		"sunflower":
			return load("res://plants/sunflower/sunflower.tscn").instantiate();
		_:
			pass;
	pass
