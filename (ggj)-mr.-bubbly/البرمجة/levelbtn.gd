extends Button

@export var level: PackedScene

func _ready() -> void:
	pressed.connect(btnPress)
	

func btnPress()->void:
	get_tree().change_scene_to_packed(level)
