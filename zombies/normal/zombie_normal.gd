extends CharacterBody2D

# 像素/毫秒
@export var speed = 15;

var life = 60;
var speed_interval = Vector2(-speed, 0);
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if life > 0:
		$walkAni.speed_scale = 17 / ( 40 / speed);
	pass

func  _physics_process(delta):
	if life > 0:
		move_and_collide(speed_interval * delta);
	pass
	
func dead():
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
	pass # Replace with function body.
