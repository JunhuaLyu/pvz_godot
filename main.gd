extends Control

signal start_new_game;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_btn_pressed():
	start_new_game.emit();
	pass # Replace with function body.
