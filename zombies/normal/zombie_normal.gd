extends CharacterBody2D

# 像素/毫秒
@export var speed = 15;

var state = "walk";
var life = 600;
var damage = 10;
var speed_interval = Vector2(-speed, 0);
var target = null;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == "walk":
		$walkAni.speed_scale = 17 / ( 40 / speed);
	pass

func  _physics_process(delta):
	if state == "walk":
		var collide = move_and_collide(speed_interval * delta);
		if collide:
			to_eating(collide);
	elif state == "eating":
		var collide = move_and_collide(speed_interval * delta);
		if !collide:
			to_walk();
	pass
	
func to_eating(collide):
	state = "eating"
	target = collide.get_collider();
	$walkAni.stop();
	$walkAni.speed_scale = 8;
	$walkAni.play("zombie_eat");
	pass;	
	
func to_walk():
	state = "walk"
	$walkAni.stop();
	$walkAni.speed_scale = 17 / ( 40 / speed);
	$walkAni.play("zombie_walk");
	pass;	
	
func dead():
	state = "dead";
	$CollisionShape2D.set_deferred("disabled", true);
	$walkAni.stop();
	$walkAni.speed_scale = 4;
	$walkAni.play("zombie_dead");
	pass;

func do_hit(damage):
	if life > 0:
		life -= damage;
		if life <= 0:
			dead();
	pass

func _on_walk_ani_animation_finished(anim_name):
	if anim_name == "zombie_dead":
		queue_free();
	elif anim_name == "zombie_eat":
		if life > 0:
			if target != null and target.has_method("under_attacked"):
				target.under_attacked(damage);
		$walkAni.play("zombie_eat");
	pass # Replace with function body.
