extends "res://plants/plant_base.gd"

var fire = preload("res://items/fire.tscn").instantiate();
func set_active(a):
	active = a;
	if active:
		$AnimatedSprite2D.play("default");
	pass;

func _on_animated_sprite_2d_animation_finished():
	fire.position = Vector2(450, self.position.y);
	get_parent().add_child(fire);
	queue_free();
	pass # Replace with function body.
