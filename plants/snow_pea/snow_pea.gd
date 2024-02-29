extends CharacterBody2D

var pea_res = preload("res://items/ice_pea.tscn");
var fighting = false;
var progress = 0;
var life = 20;
var active = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_plant_name():
	return "snow_pea";
	
func set_active(a):
	if active != a:
		progress = 0;
	active = a;
	if active:
		$AnimatedSprite2D.play();
		$CollisionShape2D.set_deferred("disabled", false);		
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !active:
		return;
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
	$Audio.play();
	var pea = pea_res.instantiate();
	pea.position = position + Vector2(30, -15);
	get_parent().add_child(pea);
	pass

func under_attacked(damage):
	life -= damage;
	if life <= 0:
		queue_free();
	pass;
