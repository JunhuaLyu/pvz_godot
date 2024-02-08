extends Node2D

var pea_shooter_tscn = preload("res://plants/pea_shooter/pea_shooter.tscn");
var sunflower_tscn = preload("res://plants/sunflower/sunflower.tscn");
var zombie_normal_tscn = preload("res://zombies/normal/zombie_normal.tscn");

var plant_selected = null;
var sunshine_list = [];
var sun_target;

# Called when the node enters the scene tree for the first time.
func _ready():
	$item_bar.connect("plant_selected", _on_plant_select);
	sun_target = $item_bar.get_sunshine_target();
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sunshine_list = sunshine_list.filter(
		func(s): 
			var width = sun_target.x - s.position.x;
			var height = sun_target.y - s.position.y;
			if abs(width) < 5 and abs(height) < 5:
				remove_child(s);
				$item_bar.add_sunshine(25);
				return false;
			var max = 4;
			var _x = width;
			var _y = height;
			if abs(width) > abs(height):			
				if _x > max:
					_x = max;
				elif _x < -max:
					_x = -max;
				_y = _x * height / width;
			else:
				if _y > max:
					_y = max;
				elif _y < -max:
					_y = -max;
				_x = _y * width / height;
				
			s.position.x += _x;
			s.position.y += _y;
			return true);	
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
	elif event is InputEventKey:
		if event.keycode == Key.KEY_1 and event.pressed == true:
			add_zombie(0);
		elif event.keycode == Key.KEY_2 and event.pressed == true:
			add_zombie(1);
		elif event.keycode == Key.KEY_3 and event.pressed == true:
			add_zombie(2);
		elif event.keycode == Key.KEY_4 and event.pressed == true:
			add_zombie(3);
		elif event.keycode == Key.KEY_5 and event.pressed == true:
			add_zombie(4);
	pass

func _on_sunshine_generated(position):
	var sunshine = Sprite2D.new();
	sunshine.texture = load("res://items/sunshine/sunshine.png");
	sunshine.position = position;
	sunshine.scale = Vector2(0.5, 0.5);
	add_child(sunshine);
	sunshine_list.append(sunshine);
	pass

func match_plant_field(position):
	for i in range(9):
		for j in range(5):
			if position.x > 145 + i * 80 - 30 and position.x < 145 + i * 80 + 30 and position.y > 135 + j * 97 - 40 and position.y < 135 + j * 97 + 40:
				plant_selected.position = Vector2(145 + i * 80, 135 + j * 97);
				if plant_selected.get_plant_name() == "sunflower":
					plant_selected.connect("sunshine_generate", _on_sunshine_generated);
					plant_selected.set_active(true);
				return true;
			# var plant_rect = Sprite2D.new();
			# plant_rect.texture = load("res://battle/item_bar.png");
			# plant_rect.region_enabled = true;
			# plant_rect.region_rect = Rect2(140, 0, 60, 60);
			#plant_rect.position = Vector2(145 + i * 80, 135 + j * 97);
			#add_child(plant_rect);
	return false;
	
func add_zombie(i):
	var zombie_normal = zombie_normal_tscn.instantiate();
	zombie_normal.position = Vector2(145 + 8 * 80, 135 + i * 97 - 24);
	add_child(zombie_normal);
	pass;
	
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
			return pea_shooter_tscn.instantiate();
		"sunflower":
			return sunflower_tscn.instantiate();
		_:
			pass;
	pass
