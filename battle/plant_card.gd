extends Node2D

signal plant_selected(name)
var plant_name
var plant_price
@export var plant_cooldown = 3.0;
var width;
var height;
var cd_cur;
# Called when the node enters the scene tree for the first time.
func _ready():
	width = $TextureRect.size.x;
	height = $TextureRect.size.y;
	cd_cur = plant_cooldown;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cd_cur < plant_cooldown:
		self.material.set_shader_parameter("range", (plant_cooldown - cd_cur) / plant_cooldown);
		cd_cur += delta;
	pass

func _input(event):
	if cd_cur < plant_cooldown:
		return;
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var local = self.to_local(event.position);
			if local.x > 0 and local.x < width and local.y > 0 and local.y < height :
				plant_selected.emit(plant_name);
	pass

func cool_down_start():
	cd_cur = 0.0;
	pass
	
func set_plant(name, sprite, price):
	plant_name = name;
	plant_price = price;
	sprite.use_parent_material = true;
	add_child(sprite);
	$Label.text = String.num(price);
	pass
