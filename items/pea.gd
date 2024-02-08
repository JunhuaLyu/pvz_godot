extends Area2D

var pea_boom_res = preload("res://items/pea_explosion.png");

@export var speed = 200;
var damage = 10;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta;
	pass

func _on_body_entered(body):
	if body.has_method("do_hit"):
		if damage > 0:
			body.do_hit(damage);
			damage = 0;
	speed = 0;
	$Sprite2D.texture = pea_boom_res;
	await get_tree().create_timer(0.1).timeout;
	queue_free();
	pass # Replace with function body.
