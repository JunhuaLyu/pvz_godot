extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_animated_sprite_2d_animation_finished():
	if self.has_overlapping_bodies():
		for body in self.get_overlapping_bodies():
			if body.has_method("under_attacked"):
				body.under_attacked(5000);
	queue_free();
	pass # Replace with function body.
