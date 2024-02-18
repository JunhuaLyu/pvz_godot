extends Node2D

var cards;

var select_card = null;
var selected_material;
var energy = 1000;
var energy_speed = 5;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Normal.zombie_name = "normal";
	
	# 路障僵尸
	$Conehead/ImageRect.texture = load("res://images/zombies/conehead/mini.png");
	$Conehead.zombie_name = "conehead";
	$Conehead/Label.text = "100";
	$Conehead/NumberSprite/Label.text = "2";
	
	# 铁桶僵尸
	$Z3/ImageRect.texture = load("res://images/zombies/buckethead/mini.png");
	$Z3.zombie_name = "buckethead";
	$Z3/Label.text = String.num_uint64(get_zombie_energy($Z3.zombie_name));
	$Z3/NumberSprite/Label.text = "3";
	
	# 铁门僵尸
	$Z4/ImageRect.texture = load("res://images/zombies/door/mini.png");
	$Z4.zombie_name = "door";
	$Z4/Label.text = String.num_uint64(get_zombie_energy($Z4.zombie_name));
	$Z4/NumberSprite/Label.text = "4";
	
	# 旗子僵尸
	$Z5/ImageRect.texture = load("res://images/zombies/flag/mini.png");
	$Z5.zombie_name = "flag";
	$Z5/Label.text = String.num_uint64(get_zombie_energy($Z5.zombie_name));
	$Z5/NumberSprite/Label.text = "5";
	
	# 橄榄球僵尸
	$Z6/ImageRect.texture = load("res://images/zombies/football/mini.png");
	$Z6.zombie_name = "football";
	$Z6/Label.text = String.num_uint64(get_zombie_energy($Z6.zombie_name));
	$Z6/NumberSprite/Label.text = "6";
	
	$Z7/NumberSprite/Label.text = "7";
	$Z8/NumberSprite/Label.text = "8";
	cards = [$Normal, $Conehead, $Z3, $Z4, $Z5, $Z6, $Z7, $Z8];
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$energy_region/Label.text = String.num_uint64(energy);
	energy += energy_speed * delta;
	pass

func cancel():
	select_card.use_parent_material = true;
	select_card = null;
	pass;

func active_zombie(name):
	var card = get_card_by_name(name);
	if card != null:
		card.cool_down_start();
	energy -= get_zombie_energy(name);
	cancel();
	pass;

func add_energy(amout):
	energy += amout;
	pass
	
func select_zombie(i):
	if not cards[i].is_ready():
		return null;
	var cost = get_zombie_energy(cards[i].zombie_name);
	if cost > energy:
		return null;

	select_card = cards[i];
	select_card.use_parent_material = false;
	return select_card.zombie_name;

func get_zombie_energy(name):
	match name:
		"normal": return 50;
		"conehead": return 100;
		"buckethead": return 200;
		"flag": return 200;
		"door": return 200;
		"football": return 500;
		_: return 99999;
		
func get_card_by_name(name):
	for card in cards:
		if card.zombie_name == name:
			return card;
	pass
