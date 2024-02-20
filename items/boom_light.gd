extends Area2D

var time = 0.5;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time -= delta;
	if time < 0:
		if self.has_overlapping_bodies():
			for body in self.get_overlapping_bodies():
				if body.has_method("under_attacked"):
					body.under_attacked(500);
		queue_free();
	pass
