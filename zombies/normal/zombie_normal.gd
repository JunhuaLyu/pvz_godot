extends CharacterBody2D

# 像素/毫秒
var walk_speed = 10;
var speed_scale = 1;
var state = "walk";
var life = 100;
var damage = 10;
var speed_interval = Vector2(-walk_speed, 0);
var target = null;
var cold_timer;
var cold_material;
# Called when the node enters the scene tree for the first time.
func _ready():
	cold_material = ShaderMaterial.new();
	var file = FileAccess.open("res://effect/ice.gdshader", FileAccess.READ);
	var code = file.get_as_text();
	var shader = Shader.new();
	shader.set_code(code);
	cold_material.shader = shader;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state == "walk":
		$walkAni.speed_scale = 17 / ( 40 / walk_speed) * speed_scale;
	pass

func  _physics_process(delta):
	if state == "walk":
		var collide = move_and_collide(speed_interval * delta * speed_scale);
		if collide:
			to_eating(collide);
	elif state == "eating":
		var collide = move_and_collide(speed_interval * delta * speed_scale);
		if !collide:
			to_walk();
	pass
	
func to_eating(collide):
	state = "eating"
	target = collide.get_collider();
	$walkAni.stop();
	$walkAni.speed_scale = 5 * speed_scale;
	$walkAni.play("zombie_eat");
	pass;	
	
func to_walk():
	state = "walk"
	$walkAni.stop();
	$walkAni.speed_scale = 17 / ( 40 / walk_speed) * speed_scale;
	$walkAni.play("zombie_walk");
	pass;	
	
func dead():
	state = "dead";
	$CollisionShape2D.set_deferred("disabled", true);
	$walkAni.stop();
	$walkAni.speed_scale = 4;
	$walkAni.play("zombie_dead");
	pass;
	
func _on_cold_timeout():
	speed_scale = 1;
	cold_timer = null;
	$Sprite2D.material = null;
	pass;
	
func on_effect_cold(effect):
	speed_scale = 0.5;
	$Sprite2D.material = cold_material;
	if cold_timer == null:
		cold_timer = get_tree().create_timer(2.0);
		cold_timer.timeout.connect(_on_cold_timeout);
	else:
		cold_timer.set_time_left(2.0);
	pass

func under_attacked(damage, effect = null):
	if life > 0:
		life -= damage;
		if effect == "cold":
			on_effect_cold(effect);
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
