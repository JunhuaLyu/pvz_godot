extends "res://items/pea.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = 10;
	return super._ready();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	return super._process(delta);

func _on_body_entered(body):
	if body.has_method("under_attacked"):
		if damage > 0:
			body.under_attacked(damage, "cold");
			damage = 0;
	speed = 0;
	$Sprite2D.texture = pea_boom_res;
	await get_tree().create_timer(0.1).timeout;
	queue_free();
	pass # Replace with function body.
