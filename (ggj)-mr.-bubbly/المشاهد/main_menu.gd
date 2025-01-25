extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_select_level_pressed():
	get_tree().change_scene_to_file("res://المشاهد/select_level_page.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://المشاهد/options_page.tscn")


func _on_credits_pressed():
	get_tree().change_scene_to_file("res://المشاهد/Credits_page.tscn")
