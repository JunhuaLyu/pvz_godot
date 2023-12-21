extends Node

var main_scene = preload("res://main.tscn").instantiate();
var battle_scene = preload("res://battle/battle.tscn").instantiate();
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(main_scene);
	main_scene.connect('start_new_game', _on_main_start_new_game);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_main_start_new_game():
	print('start_new_game');
	remove_child(main_scene);
	add_child(battle_scene);
	pass # Replace with function body.
