extends Area3D


func on_touch(body: Node3D) -> void:
	if body.has_meta("Player"):
		body.emit_signal("PlaySound","res://SoundEffects/TouchingWater.mp3")
		body.emit_signal("Hit",true)

func on_touch_leave(body: Node3D) -> void:
	if body.has_meta("Player"):
		body.emit_signal("Hit",false)
