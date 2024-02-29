extends "res://plants/plant_base.gd"

var pea_res = preload("res://items/pea.tscn");
var fighting = false;
var attack1 = 1.3;
var attack2 = 1.3;
var attack_interval = 1.4;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !active:
		return;
	if $Detect.has_overlapping_bodies():
		fighting = true;
	else:
		fighting = false;
		
	if fighting :
		attack1 += delta;
		if attack2 > attack_interval:
			attack2 += delta;
		if attack1 > attack_interval:
			emit_pea();
			attack2 = attack1;
			attack1 = 0.0;
		if attack2 > attack_interval + 0.2:
			emit_pea();
			attack2 = 0.0;
	pass

func emit_pea():
	$Audio.play();
	var pea = pea_res.instantiate();
	pea.position = position + Vector2(30, -15);
	get_parent().add_child(pea);
	pass
