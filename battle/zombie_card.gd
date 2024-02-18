extends TextureRect

@export var zombie_name = "normal";
@export var cool_down = 5;
var _cool_down_cur;
# Called when the node enters the scene tree for the first time.
func _ready():
	_cool_down_cur = cool_down;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _cool_down_cur < cool_down:
		_cool_down_cur += delta;
		$ImageRect.material.set_shader_parameter("range", (cool_down - _cool_down_cur) / cool_down);
	pass

func is_ready():
	return not _cool_down_cur < cool_down;
	
func cool_down_start():
	_cool_down_cur = 0;
	pass
