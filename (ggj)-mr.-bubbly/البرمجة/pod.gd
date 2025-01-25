extends Area3D

@export var nextLevel: PackedScene
@export var minimumBubbles: int

var playerProperties: المزايا = preload("res://الموارد/اللاعب/مزايا.tres")

func _ready() -> void:
	body_entered.connect(on_touch)
	pass

func on_touch(body: Node3D) -> void:
	if body.has_meta("Player"):
		if playerProperties.numberOfBubbles >= minimumBubbles:
			await get_tree().create_timer(1).timeout
			get_tree().change_scene_to_packed(nextLevel)
