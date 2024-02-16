extends Label

var time_left = 10 * 60 + 1;
var _count_stop = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _count_stop:
		return;
	time_left -= delta;
	if time_left < 0:
		time_left = 0;
	var sec = int(time_left) % 60;
	var min = int(time_left) / 60;
	text = "%02d:%02d" % [min,sec];
	pass

func count_stop():
	_count_stop = true;
	pass;
	
func get_time_left():
	return int(time_left);
