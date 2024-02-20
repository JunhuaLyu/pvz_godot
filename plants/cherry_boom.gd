extends "res://plants/plant_base.gd"

var boom = preload("res://items/boom_light.tscn").instantiate();
func set_active(a):
	active = a;
	if active:
		$AnimatedSprite2D.play("default");
	pass;

func _on_animated_sprite_2d_animation_finished():
	boom.position = self.position;
	get_parent().add_child(boom);
	queue_free();
	pass # Replace with function body.
