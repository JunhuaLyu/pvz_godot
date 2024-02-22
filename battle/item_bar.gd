extends Node2D

signal plant_selected(name)
var card_tscn = preload("res://battle/plant_card.tscn");
var sun_target;
var sunshine_count = 500;
# 阳光自然增长每秒
var sunshine_increase_speed = 2;
var cards = {};
# Called when the node enters the scene tree for the first time.
func _ready():	
	var w = 60;
	var l = 84;
	var plant_card = card_tscn.instantiate();
	plant_card.position = Vector2(l, 10);
	var card_sprite = load("res://plants/sunflower/sunflower_card.tscn").instantiate();	
	var name = "sunflower";
	plant_card.plant_cooldown = 5.0;
	plant_card.set_plant(name, card_sprite, get_plant_cost(name));
	plant_card.connect("plant_selected", _on_plant_select);
	add_child(plant_card);
	cards[name] = plant_card;
	
	plant_card = card_tscn.instantiate();
	plant_card.position = Vector2(l + 1 * w, 10);
	card_sprite = load("res://plants/pea_shooter/pea_shooter_card.tscn").instantiate();
	name = "pea_shooter";
	plant_card.plant_cooldown = 10.0;
	plant_card.set_plant(name, card_sprite, get_plant_cost(name));
	plant_card.connect("plant_selected", _on_plant_select);
	add_child(plant_card);
	cards[name] = plant_card;

	plant_card = card_tscn.instantiate();
	plant_card.position = Vector2(l + 2 * w, 10);
	card_sprite = Sprite2D.new();
	card_sprite.texture = load("res://images/plants/snow_pea/snow_pea_0.png");
	card_sprite.offset = Vector2(42, 40);
	card_sprite.scale = Vector2(0.6, 0.6);
	name = "snow_pea";
	plant_card.plant_cooldown = 10.0;
	plant_card.set_plant(name, card_sprite, get_plant_cost(name));
	plant_card.connect("plant_selected", _on_plant_select);
	add_child(plant_card);
	cards[name] = plant_card;
	
	plant_card = card_tscn.instantiate();
	plant_card.position = Vector2(l + 3 * w, 10);
	card_sprite = Sprite2D.new();
	card_sprite.texture = load("res://images/plants/wall_nut/wall_nut_0.png");
	card_sprite.offset = Vector2(42, 40);
	card_sprite.scale = Vector2(0.6, 0.6);
	plant_card.plant_cooldown = 30.0;
	name = "wall_nut";
	plant_card.set_plant(name, card_sprite, get_plant_cost(name));
	plant_card.connect("plant_selected", _on_plant_select);
	add_child(plant_card);
	cards[name] = plant_card;
	
	plant_card = card_tscn.instantiate();
	plant_card.position = Vector2(l + 4 * w, 10);
	card_sprite = Sprite2D.new();
	card_sprite.texture = load("res://images/plants/jalapeno/jalapeno_0.png");
	card_sprite.offset = Vector2(42, 40);
	card_sprite.scale = Vector2(0.6, 0.6);
	plant_card.plant_cooldown = 50.0;
	name = "jalapeno";
	plant_card.set_plant(name, card_sprite, get_plant_cost(name));
	plant_card.connect("plant_selected", _on_plant_select);
	add_child(plant_card);
	cards[name] = plant_card;
	
	plant_card = card_tscn.instantiate();
	plant_card.position = Vector2(l + 5 * w, 10);
	card_sprite = Sprite2D.new();
	card_sprite.texture = load("res://images/plants/repeater/repeater_0.png");
	card_sprite.offset = Vector2(42, 40);
	card_sprite.scale = Vector2(0.6, 0.6);
	plant_card.plant_cooldown = 10.0;
	name = "repeater";
	plant_card.set_plant(name, card_sprite, get_plant_cost(name));
	plant_card.connect("plant_selected", _on_plant_select);
	add_child(plant_card);
	cards[name] = plant_card;
	
	plant_card = card_tscn.instantiate();
	plant_card.position = Vector2(l + 6 * w, 10);
	card_sprite = Sprite2D.new();
	card_sprite.texture = load("res://images/plants/cherry_boom/cherry_boom_0.png");
	card_sprite.offset = Vector2(42, 40);
	card_sprite.scale = Vector2(0.6, 0.6);
	plant_card.plant_cooldown = 50.0;
	name = "cherry_boom";
	plant_card.set_plant(name, card_sprite, get_plant_cost(name));
	plant_card.connect("plant_selected", _on_plant_select);
	add_child(plant_card);
	cards[name] = plant_card;
	
	plant_card = card_tscn.instantiate();
	plant_card.position = Vector2(l + 7 * w, 10);
	card_sprite = Sprite2D.new();
	card_sprite.texture = load("res://images/plants/spike_weed/spike_weed_0.png");
	card_sprite.offset = Vector2(42, 40);
	card_sprite.scale = Vector2(0.6, 0.6);
	plant_card.plant_cooldown = 7.5;
	name = "spike_weed";
	plant_card.set_plant(name, card_sprite, get_plant_cost(name));
	plant_card.connect("plant_selected", _on_plant_select);
	add_child(plant_card);
	cards[name] = plant_card;
	
	sun_target = Vector2(40, 35);
	pass # Replace with function body.

func add_sunshine(count):
	sunshine_count += count;
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$score.text = String.num_int64(sunshine_count);
	sunshine_count += delta * sunshine_increase_speed;
	pass
	
func get_sunshine_target():
	return sun_target * self.scale;
		
func _on_plant_select(name):
	var cost = get_plant_cost(name);
	if cost <= sunshine_count:
		print("select " + name);
		plant_selected.emit(name);
	pass

func get_plant_cost(name):
	match name:
		"sunflower": return 50;
		"pea_shooter": return 100;
		"snow_pea": return 175;
		"wall_nut": return 50;
		"jalapeno": return 125;
		"repeater": return 200;
		"cherry_boom": return 150;
		"spike_weed": return 100;
		_: return 99999999;

func plant_active(name):
	var cost = get_plant_cost(name);
	sunshine_count -= cost;
	cards[name].cool_down_start();
	pass
