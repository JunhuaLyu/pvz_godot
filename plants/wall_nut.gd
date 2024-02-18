extends "res://plants/plant_base.gd"

func _process(delta):
	super._process(delta);
	$AnimatedSprite2D.material.set_shader_parameter("range", (life - life_cur) / float(life));
	pass
