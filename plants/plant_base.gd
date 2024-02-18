extends CharacterBody2D

@export var life = 1;
@export var plant_name = "";
var active = false;
var life_cur;

func _ready():
	life_cur = life;
	pass;

func get_plant_name():
	return plant_name;

func set_active(a):
	active = a;
	if active:
		$AnimatedSprite2D.play("default");
		$CollisionShape2D.set_deferred("disabled", false);
	pass;
	
func _process(delta):
	pass;

func under_attacked(damage):
	life_cur -= damage;
	if life_cur <= 0:
		queue_free();
	pass;
