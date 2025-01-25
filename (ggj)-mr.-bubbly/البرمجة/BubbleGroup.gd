extends Area3D


func _ready() -> void:
	body_entered.connect(on_touch)
	pass

func on_touch(body: Node3D) -> void:
	if body.has_meta("Player"):
		body.emit_signal("PlaySound","res://SoundEffects/AbsorbingBubbles.mp3")
		body.emit_signal("TouchedBubbles")
		queue_free()
