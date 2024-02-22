extends "res://plants/plant_base.gd"

var damage = 5.0;

func set_active(a):
	super.set_active(a);
	if active:
		$SpikeArea/CollisionShape2D.set_deferred("disabled", false);
	pass;

func _process(delta):
	super._process(delta);
	if $SpikeArea.has_overlapping_bodies():
		for body in $SpikeArea.get_overlapping_bodies():
			if body.has_method("under_attacked"):
				body.under_attacked(damage * delta);

