extends Node2D

var cards;

var select_card = null;
var selected_material;

# Called when the node enters the scene tree for the first time.
func _ready():
	selected_material = ShaderMaterial.new();
	var file = FileAccess.open("res://effect/on_fire.gdshader", FileAccess.READ);
	var code = file.get_as_text();
	var shader = Shader.new();
	shader.set_code(code);
	selected_material.shader = shader;


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
	pass

func cancel():
	select_card.use_parent_material = true;
	select_card = null;
	pass;

func select_zombie(i):
	select_card = cards[i];
	select_card.use_parent_material = false;
	return select_card.zombie_name;
