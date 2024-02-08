extends CharacterBody2D

var pea_res = preload("res://items/pea.tscn");

var fighting = false;
var progress = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_plant_name():
	return "pea_shooter";
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $detect.has_overlapping_bodies():
		fighting = true;
	else:
		fighting = false;
		
	if fighting :
		progress += 1;
		if progress == 60 * 3:
			emit_pea();
			progress = 0;
	pass

func emit_pea():
	var pea = pea_res.instantiate();
	pea.position = Vector2(30, -15);
	add_child(pea);
	pass
