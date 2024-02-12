extends Node2D

var active = false;
var progress = 0;

signal sunshine_generate(position)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_plant_name():
	return "sunflower";
	
func set_active(a):
	if active != a:
		progress = 0;
	active = a;
	if active:
		$AnimationPlayer.play("sunflower_normal");
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active :
		progress += 1;
		if progress == 60 * 10:
			sunshine_generate.emit(position);
			progress = 0;
	pass
