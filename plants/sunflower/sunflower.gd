extends CharacterBody2D

var active = false;
var progress = 0;

signal sunshine_generate(position)
# 多少秒产生一次阳光
var sunshine_generate_speed = 15;
var life = 20;
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
		$CollisionShape2D.set_deferred("disabled", false);
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active :
		progress += delta;
		if progress >= sunshine_generate_speed:
			sunshine_generate.emit(position);
			progress = 0;
	pass

func under_attacked(damage):
	life -= damage;
	if life <= 0:
		queue_free();
	pass;
	
