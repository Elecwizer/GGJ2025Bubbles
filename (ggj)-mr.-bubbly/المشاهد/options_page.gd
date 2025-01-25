extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	


func _on_volum_value_changed(value):
	AudioServer.set_bus_volume_db(0,value)


func _on_check_box_toggled(button_pressed):
	pass # Replace with function body.


func _on_full_screen_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://المشاهد/main_menu.tscn")


func _on_full_screen_3_pressed():
	get_tree().change_scene_to_file("res://المشاهد/main_menu.tscn")


func _on_full_screen_2_pressed():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
