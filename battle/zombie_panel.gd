extends Node2D

var cards;

var select_card = null;
var selected_material;
var energy = 0;
var energy_speed = 5;
# Called when the node enters the scene tree for the first time.
func _ready():
	$Normal.zombie_name = "normal";
	$Conehead/Sprite2D.texture = load("res://images/zombies/conehead/conehead_0.png");
	$Conehead/Sprite2D.region_rect = Rect2(72,20,64,64);
	$Conehead/NumberSprite/Label.text = "2";
	$Conehead.zombie_name = "conehead";
	$Conehead/Label.text = "100";
	$Z3/NumberSprite/Label.text = "3";
	$Z4/NumberSprite/Label.text = "4";
	$Z5/NumberSprite/Label.text = "5";
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
	energy -= get_zombie_energy(name);
	cancel();
	pass;

func select_zombie(i):
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
		_: return 99999;
