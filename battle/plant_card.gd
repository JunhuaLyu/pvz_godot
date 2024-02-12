extends Sprite2D

signal plant_selected(name)
var plant_name
var plant_price

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var local = self.to_local(event.position);
			if local.x > 0 and local.x < texture.get_width() and local.y > 0 and local.y < texture.get_height() :
				plant_selected.emit(plant_name);
			#if local.x > position.x and local.x < position.x + texture.get_width() and local.y > position.y and local.y < position.y + texture.get_height() :
				#plant_selected.emit(plant_name);
				#print("Left button was clicked at ", event.position)			
	# Mouse in viewport coordinates.
	#if event is InputEventMouseButton:
	#	print("Mouse Click/Unclick at: ", event.position)
	#elif event is InputEventMouseMotion:
	#	print("Mouse Motion at: ", event.position)
	pass

func set_plant(name, sprite, price):
	plant_name = name;
	plant_price = price;
	add_child(sprite);
	$Label.text = String.num(price);
	pass
