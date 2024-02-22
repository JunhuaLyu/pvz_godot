extends Node2D

var pea_shooter_tscn = preload("res://plants/pea_shooter/pea_shooter.tscn");
var snow_pea_tscn = preload("res://plants/snow_pea/snow_pea.tscn");
var sunflower_tscn = preload("res://plants/sunflower/sunflower.tscn");
var wall_nut_tscn = preload("res://plants/wall_nut.tscn");
var jalapeno_tscn = preload("res://plants/jalapeno.tscn");
var repeater_tscn = preload("res://plants/repeater.tscn");
var cherry_boom_tscn = preload("res://plants/cherry_boom.tscn");
var spike_weed_tscn = preload("res://plants/spike_weed.tscn");

var zombie_normal_tscn = preload("res://zombies/normal/zombie_normal.tscn");
var zombie_conehead_tscn = preload("res://zombies/zombie_conehead.tscn");
var zombie_buckethead_tscn = preload("res://zombies/zombie_buckethead.tscn");
var zombie_flag_tscn = preload("res://zombies/zombie_flag.tscn");
var zombie_door_tscn = preload("res://zombies/zombie_door.tscn");
var zombie_football_tscn = preload("res://zombies/zombie_football.tscn");
var zombie_jack_tscn = preload("res://zombies/zombie_jack_in_the_box.tscn");

var plant_selected = null;
var sunshine_list = [];
var sun_target;
var zombie_selected = null;
var _battle_end = false;
var _shovel = null;
var _phase = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	$item_bar.connect("plant_selected", _on_plant_select);
	sun_target = $item_bar.get_sunshine_target();
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _battle_end:
		return;
	if $CountDown.get_time_left() == 0:
		battle_end(true);
		return;
	check_phase();
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
	if _battle_end:
		return;
	if event is InputEventMouseMotion:
		if plant_selected != null:
			plant_selected.position = event.position;
			$plant_detect.position = event.position;
		elif _shovel != null:
			_shovel.position = event.position;
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			plant_selected_cancel();
			shovel_release();
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if plant_selected != null and match_plant_field(event.position):
				pass;
			elif _shovel != null:
				if _shovel.get_child(0).has_overlapping_bodies():
					for body in _shovel.get_child(0).get_overlapping_bodies():
						if body.has_method("get_plant_name"):
							body.queue_free();
			elif $ShovelSlot.get_global_rect().has_point(event.position):
				plant_selected_cancel();
				shovel_pick(event.position);
	elif event is InputEventKey:
		if zombie_selected != null:
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
			elif event.keycode == Key.KEY_ESCAPE and event.pressed == true:
				$ZombiePanel.cancel();
				zombie_selected = null;
		else:
			if event.keycode == Key.KEY_1 and event.pressed == true:
				zombie_selected = $ZombiePanel.select_zombie(0);
			elif event.keycode == Key.KEY_2 and event.pressed == true:
				zombie_selected = $ZombiePanel.select_zombie(1);
			elif event.keycode == Key.KEY_3 and event.pressed == true:
				zombie_selected = $ZombiePanel.select_zombie(2);
			elif event.keycode == Key.KEY_4 and event.pressed == true:
				zombie_selected = $ZombiePanel.select_zombie(3);
			elif event.keycode == Key.KEY_5 and event.pressed == true:
				zombie_selected = $ZombiePanel.select_zombie(4);
			elif event.keycode == Key.KEY_6 and event.pressed == true:
				zombie_selected = $ZombiePanel.select_zombie(5);
			elif event.keycode == Key.KEY_7 and event.pressed == true:
				zombie_selected = $ZombiePanel.select_zombie(6);
			elif event.keycode == Key.KEY_8 and event.pressed == true:
				zombie_selected = $ZombiePanel.select_zombie(7);
			pass
	pass

func _on_sunshine_generated(position):
	var sunshine = Sprite2D.new();
	sunshine.texture = load("res://items/sunshine/sunshine.png");
	sunshine.position = position;
	sunshine.scale = Vector2(0.5, 0.5);
	add_child(sunshine);
	sunshine_list.append(sunshine);
	pass
	
func plant_selected_cancel():
	if plant_selected != null:
		remove_child(plant_selected);
		plant_selected = null;	
	pass

func shovel_pick(position):
	if _shovel == null:
		_shovel = $ShovelSlot/Shovel;
		_shovel.get_parent().remove_child(_shovel);
		self.add_child(_shovel);
		_shovel.position = position;
	pass

func shovel_release():
	if _shovel != null:
		remove_child(_shovel);
		$ShovelSlot.add_child(_shovel);
		_shovel.position = Vector2(24, 22);
		_shovel = null;	
	pass

func match_plant_field(position):
	if $plant_detect.has_overlapping_bodies():
		return false;
	for i in range(9):
		for j in range(5):
			if position.x > 145 + i * 80 - 30 and position.x < 145 + i * 80 + 30 and position.y > 135 + j * 97 - 40 and position.y < 135 + j * 97 + 40:
				plant_selected.position = Vector2(145 + i * 80, 135 + j * 97);
				remove_child(plant_selected);
				$BattleRect.add_child(plant_selected);
				plant_selected.set_active(true);
				$item_bar.plant_active(plant_selected.get_plant_name());
				if plant_selected.get_plant_name() == "sunflower":
					plant_selected.connect("sunshine_generate", _on_sunshine_generated);
				plant_selected = null;
				return true;
	return false;
	
func add_zombie(i):
	if zombie_selected == "fog":
		$Fog.visible = true;
		$BattleRect.visible = false;
		$ZombiePanel.active_zombie(zombie_selected);
		zombie_selected = null;
		await get_tree().create_timer(20).timeout;
		$Fog.visible = false;
		$BattleRect.visible = true;
		return;
	var zombie = get_zombie(zombie_selected);
	zombie.position = Vector2(900, 135 + i * 97 - 18);
	$BattleRect.add_child(zombie);
	$ZombiePanel.active_zombie(zombie_selected);
	zombie_selected = null;
	pass;
	
func _on_plant_select(name):
	if _battle_end:
		return;
	if plant_selected != null:
		remove_child(plant_selected);
	plant_selected = get_plant_selected_sprite(name);
	if plant_selected != null:
		plant_selected.position = Input.get_last_mouse_velocity();
		add_child(plant_selected);
		shovel_release();
	pass
	
func get_plant_selected_sprite(plant_name):
	var plant;
	match plant_name:
		"pea_shooter":
			plant = pea_shooter_tscn.instantiate();
		"snow_pea":
			plant = snow_pea_tscn.instantiate();
		"sunflower":
			plant = sunflower_tscn.instantiate();
		"wall_nut":
			plant = wall_nut_tscn.instantiate();
		"jalapeno":
			plant = jalapeno_tscn.instantiate();
		"repeater":
			plant = repeater_tscn.instantiate();
		"cherry_boom":
			plant = cherry_boom_tscn.instantiate();
		"spike_weed":
			plant = spike_weed_tscn.instantiate();
		_:
			pass;
	plant.scale = Vector2(0.8, 0.8);
	return plant;

func _on_zombie_selected(name):
	zombie_selected = name;
	pass

func get_zombie(zombie_name):
	var zombie;
	match zombie_name:
		"normal":
			zombie = zombie_normal_tscn.instantiate();
		"conehead":
			zombie = zombie_conehead_tscn.instantiate();
		"buckethead":
			zombie = zombie_buckethead_tscn.instantiate();
		"flag":
			zombie = zombie_flag_tscn.instantiate();
		"door":
			zombie = zombie_door_tscn.instantiate();
		"football":
			zombie = zombie_football_tscn.instantiate();
		"jack_in_the_box":
			zombie = zombie_jack_tscn.instantiate();
		_:
			zombie = zombie_normal_tscn.instantiate();
	zombie.scale = Vector2(0.9, 0.9);
	zombie.z_index = 1;
	return zombie;

func battle_end(plant_win):
	_battle_end = true;
	$Label.visible = true;
	if plant_win:
		$Label.text = "植物胜利!";
	else:
		$Label.text = "僵尸胜利!";
	pass

func _on_zombie_win_line_body_entered(body):
	battle_end(false);
	$CountDown.count_stop();
	pass # Replace with function body.

func check_phase():
	var secs = $CountDown.get_time();
	var phase = int(secs / 120);
	if _phase != phase:
		to_phase(phase);
	pass

func to_phase(phase):
	_phase = phase;
	match phase:
		1: 
			$ZombiePanel.add_energy(200);
			$ZombiePanel.energy_speed = 8;
		2: 
			$ZombiePanel.add_energy(400);
			$ZombiePanel.energy_speed = 12;
		3: 
			$ZombiePanel.add_energy(700);
			$ZombiePanel.energy_speed = 18;
		4: 
			$ZombiePanel.add_energy(1200);
			$ZombiePanel.energy_speed = 25;
		_: return;
	$ZombiesComingRect.visible = true;
	await get_tree().create_timer(1).timeout;
	$ZombiesComingRect.visible = false;
	pass
