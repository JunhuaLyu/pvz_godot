extends PointLight2D

signal btn_pressed;
var pressed = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enabled = pressed;
	pass
	
func _unhandled_input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ENTER:
			if event.is_pressed():
				pressed = true;
			elif event.is_released():
				pressed = false;
				btn_pressed.emit();
			elif event.is_canceled():
				pressed = false;
				
		print('startBtn ' + event.as_text())
	pass
