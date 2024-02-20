extends "res://zombies/zombie_base.gd"

var boom_tscn = preload("res://items/boom.tscn");

func _on_animated_sprite_2d_animation_finished():
	if state == "eating" and _life < life / 2:
		var boom = boom_tscn.instantiate();
		boom.position = Vector2(self.position.x + 20, self.position.y);
		get_parent().add_child(boom);
		queue_free();
		return;
	super._on_animated_sprite_2d_animation_finished();
