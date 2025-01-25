extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://المشاهد/main_menu.tscn")
	pass # Replace with function body.
